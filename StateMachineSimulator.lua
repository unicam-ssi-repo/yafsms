

require "IsEqual"


configurations= {}
currentState= nil


 -- STATE 

State= {} 
State.__index = State 

states= {}


function State.new(n)
  local s= {name= n, entry= nil, doo= nil, exitt= nil, transitions= {}, counter= 0}
  return setmetatable(s,State)
end


function State.add(self)
  table.insert(states, self)
end


function State.setCurrentState(self)
  currentState= self
  self.counter= self.counter + 1
end



function State.addTransition(self, e, c, a, n)
  table.insert(self.transitions, {events= e, condition= c or nil, actions= a or nil, nextState= n})
end


function State.setEntry(self,f)
  self.entry= f
end


function State.setDoo(self, f)
  self.doo= f
end


function State.setExitt(self, f)
  self.exitt= f
end


function isNilEntry(State)
  if State.entry == nil then
    return true
  else
    return false
  end
end


function isNilDoo(State)
  if State.doo == nil then
    return true
  else
    return false
  end
end


function isNilExitt(State)
  if State.exitt == nil then
    return true
  else
    return false
  end
end


function executeEde(ede)
  for i, v in ipairs(ede) do
    v.functionn()
  end
end


function printStateCounter()
  for i, v in ipairs(states) do
    logFile: write("\n".."state: "..v.name.."--> ".."occurrences: "..v.counter, "\n")
  end
end


function printTransitions(events, condition, actions)
  for i, v in ipairs(events) do
      logFile: write("E: "..v.name.."  ")
    end
    if condition ~= nil then
      logFile: write(" C: ["..tostring(condition).."]".." / A: ")
    else
      logFile: write(" C: []".." / A: ")
    end
    if actions ~=nil then
      for h, k in ipairs(actions) do
        logFile: write(k.name.."; ")
      end
    else
      logFile: write("__; ")
    end
end


  
-- SENSOR
Sensor= {} 
Sensor.__index = Sensor 

sensors= {}


function Sensor.new(n, t, v, min, max) -- nome del sensore, tipo (number/boolean)
  assert(type(v) == t, "no match type, please insert a new value")
  if t == "number" then
    assert(v >= min and v <= max, "please, respect the range")
    local s= {name= n, typee= t, val= v, min= min, max= max, change= false, counterVal= 0, counterCha= 0}
    return setmetatable(s, Sensor)
  else
    local s= {name= n, typee= t, val= v, min= min, max= max, change= false, counterVal= 0, counterCha= 0}
    return setmetatable(s, Sensor)
  end
end


function Sensor.add(self)
  table.insert(sensors, self)
end


function Sensor.setValue(self, v)
  
  if logFile then
    logFile: write("Initial State: "..currentState.name, "\n")
    logFile: write("Modified Sensor: "..self.name.."; ")
    assert(type(v) == self.typee, "no type matching")
    
    if type(v) == "boolean" then
      logFile: write("Sensor Value: "..tostring(v), "\n" )
    else
      
      logFile: write("Sensor Value: "..v, "\n" ) 
      assert(v >= self.min and v <= self.max, "out of range")
    end
    
    if self.val == v then
      return
    end
    
    self.val= v
    self.counterVal= self.counterVal + 1
    
    if self.change == false then
      self.change= true
      run()
    else
      run()
    end
    
    
  else
    assert(type(v) == self.typee, "no type matching")
    if type(v) == "number" then
      assert(v >= self.min and v <= self.max, "out of range")
      if self.val == v then
        return
      end
      self.val= v
      self.counterVal= self.counterVal + 1
      
      if self.change == false then
        self.change= true
        run()
      else
        run()
      end
    else
      if self.val == v then
        return
      end
      self.val= v
      self.counterVal= self.counterVal + 1
      
      if self.change == false then
        self.change= true
        run()
      else
        run()
      end
      
      return currentState.name
    end
  end
  return currentState.name
end


function Sensor.getValue(self)
  return self.val
end


function randomSensorValue(simTable)
  local s= simTable[math.random(#simTable)]
  local sensor= s[1]
  if sensor.typee == "boolean" then
    local a= math.random(0, 1)
    if a == 0 then
      sensor: setValue(false)
    else
      sensor: setValue(true)
    end
  else
    if sensor.typee == "number" then
      sensor: setValue(math.random(s[2], s[3]))
    end
  end
   return currentState
end


function randomSensorValue2()
  local sensor= sensors[math.random(#sensors)]
  if sensor.typee == "boolean" then
    local a= math.random(0, 1)
    if a == 0 then
      sensor: setValue(false)
    else
      sensor: setValue(true)
    end
  else
    if sensor.typee == "number" then
      sensor: setValue(math.random(sensor.min, sensor.max))
    end
  end
   return currentState
end


function printSensorsCounters()
  for i, v in ipairs(sensors) do
    logFile: write("\n".."sensor: "..v.name.."--> ".."change occurrences: "..v.counterVal.."; ".."transitions produced: "..v.counterCha, "\n")
  end
end




-- ACTUATOR

Actuator= {}
Actuator.__index = Actuator 

actuators= {}


function Actuator.new(n, t, v, min, max)
  assert(type(v) == t, "no match type, please insert a new value")
  if t == "number" then
    assert(v >= min and v <= max, "please, respect the range")
    local a= {name= n, typee= t, val= v, min= min, max= max, change= false, counterVal= 0, counterCha= 0}
    return setmetatable(a, Actuator)
  else
    local a= {name= n, typee= t, val= v, min= min, max= max, change= false, counterVal= 0, counterCha= 0}
    return setmetatable(a, Actuator)
  end
end


function Actuator.add(self)
  table.insert(actuators, self)
end


function Actuator.setValue(self, v)
  assert(type(v) == self.typee, "no type matching")
  if type(v) == "number" then
    assert(v >= self.min and v <= self.max, "out of range")
    if self.val == v then
     return
    end
    self.val= v
    self.counterVal= self.counterVal + 1
    if self.change == false then
     self.change= true
    end
  else
    if self.val == v then
     return
    end
    self.val= v
    self.counterVal= self.counterVal + 1
    if self.change == false then
     self.change= true
    end
    return currentState.name
  end
end


function Actuator.getValue(self)
  return self.val
end


function printActuatorsCounters()
  for i, v in ipairs(actuators) do
    logFile: write("\n".."actuator: "..v.name.."--> ".."change occurrences: "..v.counterVal.."; ".."transitions produced: "..v.counterCha, "\n")
  end
end

function executeActions(actions)
  for i, v in ipairs(actions) do
    v.functionn()
  end
end








function run()
  local l= true -- variabile per uscire dal for dopo aver letto una sola transizione
  
  for i, v in ipairs(currentState.transitions) do
    
    if l then
      
    saveEvents= v.events
    
    if countEvents(v.events) == #v.events then
    
      if v.condition ~= nil then
        
        local c= v.condition[1]()
        
        if v.condition[1]() == true then
          
          if isNilExitt(currentState) == false then
            executeEde(currentState.exitt)
          end
          
          setChangeFalse(saveEvents)
          
          if v.actions ~=nil then 
            executeActions(v.actions)
          end
      
          if logFile then
            printTransitions(v.events, c, v.actions)
          end
          
        
          currentState= v.nextState
          currentState.counter= currentState.counter + 1
       
          if logFile then
            logFile: write("  ".."Arrival State: "..currentState.name, ";  ")
          end
          
         
          incrementCounterCha(saveEvents)
          setConfiguration(currentState, sensors, actuators)
          
          if checkConfiguration() == true then
            if logFile then
              return logFile: write("\n".."THERE IS A LOOP","\n")
            else 
              return print("THERE IS A LOOP")
            end
          else
            l= false
            run() 
          end
        
          if isNilEntry(currentState) == false then
            executeEde(currentState.entry)
          end
          
          if isNilDoo(currentState) == false then
            executeEde(currentState.doo)
          end
           
        end -- end if v.condition == "true" 
        
      else
        
        if isNilExitt(currentState) == false then
          executeEde(currentState.exitt)
        end
        
        setChangeFalse(saveEvents)
        
        if v.actions ~= nil then
          executeActions(v.actions)
        end
        
        if logFile then
          printTransitions(v.events, c, v.actions)
        end
    
        currentState= v.nextState
        
        if logFile then
          logFile: write("--> ".."Arrival State: "..currentState.name, "; ")
        end
      
        incrementCounterCha(saveEvents)
        setConfiguration(currentState, sensors, actuators)
        
        if checkConfiguration() == true then 
          if logFile then
            return logFile: write("\n".."THERE IS A LOOP","\n")
          else 
            return print("THERE IS A LOOP")
          end
        else
          l= false
          run() 
        end
      

        if isNilEntry(currentState) == false then
           executeEde(currentState.entry)
        end
        
        if isNilDoo(currentState) == false then 
           executeEde(currentState.doo)  
        end
        
      end -- end if v.condition ~= nil
    
    end -- end if countEvents(v.events) == #v.events
  end -- if l then
  end -- end for
  
 return currentState.name
end


function simulator(n, simTable)
  logFile= io.open("logFile", "w")
  for i= 1, n do
    if checkConfiguration(cu, ne) == true then
      logFile: write(" ".."\n")
      printStateCounter()
      printSensorsCounters()
      printActuatorsCounters()
      return logFile: close()
    end
    resetConfiguration()
    logFile: write(" ", "\n")
    logFile: write("\n".."SIMULATION "..i, "\n")
    if simTable == nil then
      randomSensorValue2()
    else
      randomSensorValue(simTable)
   end
   
  end
  logFile: write(" ".."\n") 
  printStateCounter()
  printSensorsCounters()
  printActuatorsCounters()
  
  logFile: close()
  
  return currentState
end




  
  
  -- UTILS

function countEvents(eventi)
  count= 0
  for i, v in ipairs(eventi) do
    if v.change == true then
      count= count + 1
    end
  end
  return count
end


function setChangeFalse(events)
  for i, v in ipairs(events) do
    v.change= false
  end
end


function incrementCounterCha(events)
  for i, v in ipairs(events) do
    v.counterCha= v.counterCha + 1
  end
end


function resetStateMachine()
  currentState= nil
  for i, v in ipairs(states) do
    v.counter= 0
  end
  for i, v in ipairs(sensors) do
    v.val= nil
    v.change= false
    v.counterVal= 0
    v.counterCha= 0
  end
  for i, v in ipairs(actuators) do
    v.val= nil
    v.change= false
    v.counterVal= 0
    v.counterCha= 0
  end
  
  logFile= nil
  os.remove("logFile")
  
end

-- CONFIGURATIONS

function setConfiguration(state, sensors, actuators)
  table.insert(configurations, {state, sensors, actuators})
end

function resetConfiguration()
  configurations= {}
end


function checkConfiguration()
  countLoop= 0
  for i= 1, #configurations do
    local conf = configurations[i]
    for j= i + 1, #configurations do
      if isEqual(conf, configurations[j]) == true then
        countLoop=  countLoop + 1
      end
    end
end
  if countLoop == 0 then
    return false
  else
    return true
  end
end -- function
        
  
  

    