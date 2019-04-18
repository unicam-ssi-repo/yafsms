
require "StateMachineSimulator"

--STATES

on= State.new("on")
on: add()

off= State.new("off")
off: add()


--SENSORS
lux= Sensor.new("lux", "boolean", false)
lux: add()


--ACTUATORS
lamp= Actuator.new("lamp", "boolean", false)
lamp: add()


--FUNCTIONS
turnOnLamp= {name= "turnOnLamp", functionn= function() lamp: setValue(true) print("turnOnLamp") end}
turnOffLamp= {name= "turnOffLamp", functionn= function() lamp: setValue(false) print("turnOffLamp") end}



--CONDITIONS
c1= function() return lux: getValue() == true end
c2= function() return lux: getValue() == false end
c3= function() return lamp: getValue() == true end
c4= function() return lamp: getValue() == false end


--TRANSITIONS
off: addTransition({lux}, {c2}, {turnOnLamp}, on)
on: addTransition({lux}, {c1}, {turnOffLamp}, off)


--LOOP generato dalla macchina
-- off: addTransition({lux}, {c2}, {turnOnLamp}, on)
-- off: addTransition({lamp}, {c4}, {turnOnLamp}, on)
-- on: addTransition({lamp}, {c3}, {turnOffLamp}, off)



off: setCurrentState()

simulator(50, nil)
