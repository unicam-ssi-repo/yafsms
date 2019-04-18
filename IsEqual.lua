

function isEqualState(state1, state2)
  if state1 ~= state2 then
    return false
  else
    return true
  end
end

  
  function isEqualActuator(actuators1, actuators2) 
  
  for i, v in ipairs(actuators1) do
    for k, z  in ipairs(actuators2) do
      
      if v.name ~= z.name then
        return false
      else
        
        if v.typee ~= z.typee then
          return false
        else
        
          if v.val ~= z.val then
            return false
          end
        
        end
      
      
      end
      return true
    end
    
  end
end

        
  
  
  function isEqual(configurations1, configurations2)  
   
    if isEqualState(configurations1[1].name, configurations2[1].name) == false then
      return false
          
    else
      if isEqualActuator(configurations1[3], configurations2[3]) == false then
        return false
      end
          
    end
    
    return true
  end
   

            
      
      
      
      