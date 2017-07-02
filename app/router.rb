class Router
 def initialize(request)
   @request = request
 end

 def route!
   if klass = controller_class
     add_route_info_to_params(route_info)

     controller = klass.new(@request)
     action = route_info[:action]

     if controller.respond_to?(action)
       puts "Routing to #{klass}##{action}"
       return controller.public_send(action)
     else
       puts "#{klass} does not have action #{action}"
     end
   end
   not_found
 end


 private

 def add_route_info_to_params(info)
   @request.params.merge!(info)
 end

 def not_found
   content = File.open('app/views/404.html').readlines.map(&:chomp)
   ['404', { 'Content-Type' => 'text/html; charset=utf-8' }, content]
 end

 def route_info
   @route_info ||= begin
     resource = path_fragments[0] || 'base'
     id, action = find_id_and_action(path_fragments[1])
     {}.tap do |h|
       h[:resource] = resource
       h[:action] = action
       h[:id] = id
     end
   end
 end

 def path_fragments
   @fragments ||= @request.path.split('/').reject { |s| s.empty? }
 end

 def find_id_and_action(fragment)
   case fragment
   when 'new'
     [nil, :new]
   when nil
     [nil, @request.get? ? :index : :create]
   else
     [fragment, :show]
   end
 end

 def controller_name
   "#{route_info[:resource].capitalize}Controller"
 end

 def controller_class
   Object.const_get(controller_name)
 rescue NameError
   nil
 end
end
