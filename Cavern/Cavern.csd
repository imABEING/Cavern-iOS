<Cabbage>

form caption("Cavern"), size(500, 400), pluginid("Cavern"), colour("0, 0, 0")
image file("bluePlate.jpg"), bounds(0, 0, 500, 400), outlinecolour(0, 0, 0, 255), 

{
checkbox bounds(156, 308, 20, 20), channel("led1"), text(""), shape("circle") colour:1(0, 45, 0, 255)
checkbox bounds(141, 266, 20, 20), channel("led2"), text(""), shape("round")  colour(0, 60, 0) 
checkbox bounds(138, 226, 20, 20), channel("led3"), text(""), shape("circle") colour:1(0, 75, 0, 255)
checkbox bounds(162, 190, 20, 20), channel("led4"), text(""), shape("circle") colour:1(0, 100, 0, 255)
checkbox bounds(209, 160, 20, 20), channel("led5"), text(""), shape("round")  colour(0, 125, 0) 
checkbox bounds(267, 160, 20, 20), channel("led6"), text(""), shape("circle") colour:1(0, 150, 0, 255)
checkbox bounds(308, 190, 20, 20), channel("led7"), text(""), shape("round")  colour(0, 175, 0) 
checkbox bounds(336, 226, 20, 20), channel("led8"), text(""), shape("round")  colour(0, 200, 0) 
checkbox bounds(336, 266, 20, 20), channel("led9"), text(""), shape("circle") colour:1(0, 225, 0, 255)
checkbox bounds(324, 308, 20, 20), channel("led10"), text(""), shape("round") colour(0, 255, 0) 
}

image file("Cavern.png"), bounds(40, 12, 420, 116), , outlinecolour(0, 0, 0, 255)
image file("knob_10_shadow_001.png"), bounds(150, 180, 200, 200), tofront(), outlinecolour("0, 0, 0")

image bounds(150, 180, 200, 200), file("knob_05_001.png") 
image bounds(150, 180, 200, 200), file("knob_05_001.png"), identchannel("sliderIdent")

rslider bounds(150, 180, 160, 165), channel("reverb"), range(0.03, 1, 0, 1, .01), trackercolour("0, 210, 0, 0"), imgfile("slider", "metalKnob2.png"), imgfile("background", "tp.png"), alpha(0) ;rotate(2.5, 100, 102) 

label align("centre"),  alpha(.35), bounds(350, 370, 150, 20), channel("chan"), colour("0,0,0,0"), fontcolour("0,192,192"), text("@rolexalexx")


</Cabbage>
<CsoundSynthesizer>
<CsOptions>
-o dac
-d
-i adc
</CsOptions>
<CsInstruments>
sr        = 44100
ksmps     = 64
nchnls    = 2
0dbfs	  = 1

instr 1
kSlider chnget "reverb"
if changed(kSlider)==1 then
	chnset kSlider>0.05 ? k(1) : k(0), "led1"
	chnset kSlider>0.1 ? k(1) : k(0), "led2"
	chnset kSlider>0.2 ? k(1) : k(0), "led3"
	chnset kSlider>0.3 ? k(1) : k(0), "led4"
	chnset kSlider>0.4 ? k(1) : k(0), "led5"
	chnset kSlider>0.5 ? k(1) : k(0), "led6"
	chnset kSlider>0.6 ? k(1) : k(0), "led7"
	chnset kSlider>0.7 ? k(1) : k(0), "led8"
	chnset kSlider>0.8 ? k(1) : k(0), "led9"
	chnset kSlider>0.9 ? k(1) : k(0), "led10"
endif
endin

instr 2
gkfeed init 0.05
gkvol init 0.1
gkfco init 12000
gkpm = 20
;0 - 20


gkfeed = chnget:k("reverb")
gkvol = chnget:k("dry")
gkpm = chnget:k("color")
gkfco = chnget:k("cutoff")

if metro(25) == 1 then
        if changed(gkfeed) == 1 then
            SMessage sprintfk "rotate(%f, 100, 80, 80)", (gkfeed*3.14159265359)*1.5
            chnset SMessage, "sliderIdent"
        endif
    endif


asig1 init 0
asig2 init 0
;aenv adsr .1, .2, .2, .2
asig1,asig2 ins

;hpf
;


arev, arev2 reverbsc asig1, asig2, gkfeed, gkfco, sr, i(gkpm), 1
printk2 gkpm
printk2 gkfco


ktrig	changed	gkfeed, gkpm, gkvol, gkfco
 if ktrig==1 then
  reinit	UpdateValues
 endif
 UpdateValues:
 gkfeed		=	i(gkfeed)
 gkpm		=	i(gkpm)
 gkvol		=	i(gkvol)
 gkfco	=	i(gkfco)
 rireturn

outs asig1*gkvol, asig2*gkvol
outs arev, arev2


garvb  = 0	;clear
endin
</CsInstruments>
<CsScore>
f 1 0 16384 9 1
i 1 0 z
i 2 0 z
</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>543</x>
 <y>273</y>
 <width>637</width>
 <height>405</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>reverb</objectName>
  <x>125</x>
  <y>144</y>
  <width>20</width>
  <height>100</height>
  <uuid>{88fd3ac9-e7ff-49b4-9387-fe7b4b165790}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.88000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>dry</objectName>
  <x>189</x>
  <y>143</y>
  <width>20</width>
  <height>100</height>
  <uuid>{a1adfa7e-d47f-4248-857e-c6d00ffab727}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <value>0.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
 <bsbObject version="2" type="BSBVSlider">
  <objectName>cutoff</objectName>
  <x>246</x>
  <y>141</y>
  <width>20</width>
  <height>100</height>
  <uuid>{82e3c194-4996-4d2d-ad70-9f655b0a1924}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <minimum>1000.00000000</minimum>
  <maximum>20000.00000000</maximum>
  <value>0.00000000</value>
  <mode>lin</mode>
  <mouseControl act="jump">continuous</mouseControl>
  <resolution>-1.00000000</resolution>
  <randomizable group="0">false</randomizable>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
