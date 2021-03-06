OSCFunc.trace(true);
OSCFunc.trace(false);


Supercollider:

/////////
(
SynthDef("rand_osc4", {

arg pick, freq, trig;

var control;
// D-----------F#----------A-------------- is DM here 1,3,5
pick = Dxrand([86,74,62,50,90,78,66,54,93,81,69,57],inf);

// converts the midi numbers to a frequency
freq = Demand.kr(trig,0,pick).midicps;

a = 0.25; // attack time (in seconds)
d = 1; // decay time
control = EnvGen.ar(Env([0, 0.1, 0], [a,d]), Trig.ar(trig,a+d));

//final output to the channels (is this stereo?)
Out.ar(0, SinOsc.ar(freq) * control);

}).send(s);
)

a= Synth("rand_osc4", [\trig, 1])  //start synth
b= Synth("rand_osc4", [\trig, 1])
c= Synth("rand_osc4", [\trig, 1])
a.free   //remove synth
b.free
c.free


s.dumpOSC(1)
o = OSCFunc({|msg, time, addr, recvPort| \matching.postln; Synth("rand_osc4", msg[1]]); msg[1].postln; }, '/test');

