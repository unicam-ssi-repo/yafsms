
require "StateMachineSimulator"


--STATES
sleep= State.new("sleep")
sleep: add()
  
arm= State.new("arm")
arm: add()
  
alarm= State.new("alarm")
alarm: add()



--SENSORS
key= Sensor.new("key", "number", 1234, 1234, 1234)
key: add()

insKey= Sensor.new("insKey", "number", 1233, 1233, 1236)
insKey: add()

move= Sensor.new("move", "boolean", false)
move: add()

window=  Sensor.new("window", "boolean", false)
window: add()
  
  
  
--ACTUATORS
siren= Actuator.new("siren", "boolean", false)
siren: add()
  
redLed= Actuator.new("redLed", "boolean", false)
redLed: add()
  
greenLed= Actuator.new("greenLed", "boolean", false)
greenLed: add()

beep= Actuator.new("beep", "boolean", false)
beep: add()

lamp= Actuator.new("lamp", "boolean", false)
lamp: add()


  
--FUNCTIONS
turnOnBeep= {name= "turnOnBeep", functionn= function() beep: setValue(true) print("turnOnBeep") end}
turnOffBeep= {name= "turnOffBeep", functionn= function() beep: setValue(false) print("turnOffBeep") end}

turnOnRedLed= {name= "turnOnRL", functionn= function() redLed: setValue(true) print("turnOnRedLed") end}
turnOffRedLed= {name= "turnOffRedLed", functionn= function() redLed: setValue(false) print("turnOffRedLed") end}

turnOnGreenLed= {name= "turnOnGreenLed", functionn= function() greenLed: setValue(true) print("turnOnGreenLed") end}
turnOffGreenLed= {name= "turnOffGreenLed", functionn= function() greenLed: setValue(false) print("turnOffGreenLed") end}

turnOnSiren= {name= "turnOnSiren", functionn= function() siren: setValue(true) print("turnOnSiren") end}
turnOffSiren= {name= "turnOffSiren", functionn= function() siren: setValue(false) print("turnOffSiren") end}

turnOnLamp= {name= "turnOnLamp", functionn= function() lamp: setValue(true) print("turnOnLamp") end}
turnOffLamp= {name= "turnOffLamp", functionn= function() lamp: setValue(true) print("turnOffLamp") end}
  
  
  
--set entry, do, exit
sleep: setExitt({turnOnBeep})
arm: setEntry({turnOnGreenLed})
arm: setExitt({turnOffGreenLed})
alarm: setEntry({turnOnRedLed})
alarm: setDoo({turnOnSiren}) 
alarm: setExitt({turnOnBeep})
  
  
--conditions
c1= function() return insKey: getValue() == key: getValue() end 
c2= function() return move: getValue() == true end
c3= function() return window: getValue() == true end 
  
  
-- Transitions
sleep: addTransition({insKey}, {c1}, {turnOffBeep}, arm) 
  
arm: addTransition({insKey}, {c1} , nil, sleep)
arm: addTransition({move}, {c2}, {turnOnLamp}, alarm)
arm: addTransition({window}, {c3}, {turnOnLamp}, alarm)
  
alarm: addTransition({insKey}, {c1}, {turnOffSiren, turnOffLamp, turnOffBeep}, sleep)
  



--LOOP GENERATO DALLA MACCHINA
-- arm: addTransition({beep}, nil, {turnOnBeep}, sleep)
-- sleep: addTransition({beep}, nil, nil, arm)



sleep: setCurrentState()

simulator(10, {{insKey, 1233, 1235}, {move, nil, nil}, {window, nil, nil}})


--simulator(50, nil)


-- insKey: setValue(1235)

-- insKey: setValue(1234)

-- window: setValue(true)

-- key: setValue(1236)

-- key: setValue(1234)


  
  