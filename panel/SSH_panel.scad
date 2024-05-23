HP=5.08;
angle=135;
spacing=9.5; //TODO
$fn=20;
draw_jack_plugs=false;

module obwodka(size,diam,width)
{
    difference()
    {
        hull()
        {
            for(x=[diam,size[0]-diam])
            for(y=[diam,size[1]-diam])
                translate([x,y])
                circle(r=diam);
        }
        hull()
        {
            for(x=[diam,size[0]-diam])
            for(y=[diam,size[1]-diam])
                translate([x,y])
                circle(r=diam-width);
        }
    }
}

module panel(n)
{
    difference()
    {
        translate([0.1,0,0])
        cube([n*HP-0.2,128.5,3]);
        for(x=[1.5*HP,(n-1.5)*HP])
        for(y=[3,125.5])
            translate([x,y,-1])
            hull()
            {
                translate([-1,0,0])
                cylinder(r=1.6,h=10);
                translate([1,0,0])
                cylinder(r=1.6,h=10);
            }
    }
}

module jack_in(cut)
{
    if(cut)
        translate([0,0,-1])
        cylinder(d=6.2,h=10);
    else
        translate([0,0,0])
        color("grey")
        difference()
        {
            cylinder(d=6.2,h=4);
            translate([0,0,-1])
            cylinder(d=5,h=6);
        }
}

module jack_out(cut)
{
   
   
    if(cut)
    {  
        translate([0,0,-1])
        cylinder(d=6.2,h=10);
    }
    else
        translate([0,0,0])
        color("grey")
        difference()
        {
            cylinder(d=6.2,h=4);
            translate([0,0,-1])
            cylinder(d=5,h=6);
        }
}


module pot(cut,col="green")
{
    if(cut)
        translate([0,0,-1])
        cylinder(d=7.1,h=10);
    else
        translate([0,0,3.5])
        union()
        {
            color("grey")
            cylinder(d=16,h=4.5);
            color("grey")
            cylinder(d1=13,d2=11,h=17);
            color(col)
            translate([0,4.5,9])
            cube([1.2,4,17],true);
            color(col)
            translate([0,0,15.5])
            intersection()
            {
                cylinder(h=2,d=7);
                translate([0,-3.5,0])
                cube([7,7,7],true);
            }
        }
}

module switch6(cut)
{
    if(cut)
    {
    
    //had to round corners with 3mm radius to deal with milling process    //cube([0.2+3.8+5*3,0.2+4.2,8],true);
        hull()
        for(x=[-0.5,0.5])
        for(y=[-0.5,0.5])
            translate([x*(0.2+3.8+5*3),y*(0.2+4.2-3),-4])
            cylinder(d=3,h=8);
    }
    else
        color("grey")
        translate([0,0,3.5+4.5/2])
        cube([0.2+3.8,0.2+4.2,4.5],true);
       
}

module toggle(cut)
{
    if(cut)
        translate([0,0,-1])
        cylinder(d=6.3,h=10);
    else
        rotate([0,30,90])
        cylinder(d=4,h=10);
}

module arrow_in()
{
    translate([-1,0,0])
    square([3,0.5],true);
    translate([1,0,0])
    for(i=[-1,1])
    rotate(40*i)
    translate([-0.7,0])
    square([1.5,0.5],true);
    difference()
    {
        circle(d=4);
        circle(d=3);
    }
}

module arrow_out()
{
    translate([-1.5,0,0])
    square([3,0.5],true);
    translate([-3.5,0,0])
    for(i=[-1,1])
    rotate(40*i)
    translate([0.7,0])
    square([1.5,0.5],true);
    difference()
    {
        circle(d=4);
        circle(d=3);
    }
}

module opis_atenuv(normalizowane_do_0)
{
    translate([0,spacing])
    if (normalizowane_do_0>0){
        difference()
            {
            text("0",size=2.5,halign="center",valign="center");
            }
        }
    rotate(-angle)
    translate([0,spacing])
    {
        rotate(angle)
        square([2,0.4],true);
        rotate(angle)
        square([0.4,2],true);
    }
    rotate(angle)
    translate([0,spacing])
    {
        rotate(-angle)
        square([2,0.4],true);
    }
}

module opis_galek(not_middle)
{
    ile=6;
    for(i=[-ile:ile])
        if(i!=0 || not_middle<1)
            rotate(i*angle/(ile+1))
            translate([0,spacing-1])
            square([0.4,1],true);
}

switch_level=73;
lower_element=48;
higher_element=105;

module elementy_sub(cut)
{
    for(x=[1:3])
        translate([HP*(2+4*x),0,0])
        {
            translate([0,lower_element,0])
            pot(cut);
            translate([0,switch_level,0])
            rotate([0,0,90])
            switch6(cut);
            translate([0,higher_element,0])
            pot(cut);
        }        
    translate([HP*2,switch_level,0])
    rotate([0,0,90])
    switch6(cut);
    translate([HP*2,higher_element,0])
    toggle(cut);
    translate([HP*2,lower_element,0])
    pot(cut);
    for(x=[0:4])
    {
        translate([16/5*HP*(0.5+x),15,0])
        {
        jack_out(cut);
        if(draw_jack_plugs)
            color("blue")
            cylinder(d=10,h=15);
       
        }
        translate([16/5*HP*(0.5+x),26,0])
        jack_in(cut);
       
       
    }
   
}

SSH_font="Latin modern";

//off spaces to U+2006  SIX-PER-EM SPACE
bankA=["ON","÷2","÷4","÷8","÷16","OFF"];
bankB=["÷2","÷3","÷4","÷5","÷8","OFF"];
control=["Ø","X","D","A","3","4"];
switch=["II","I"];
param=["X","D","A"];
higher_jacks=["IN", "CLK"];
lower_jacks=["OUT", "AUX"];
dodatek=7;

module napisy()
//wszystkie napisy ida tutaj!!!
translate([0,0,3])
linear_extrude(0.2)
{
    opisyBankowSize=2.5;
    //bank 1 slider opisy
    for(i=[0:5])
        translate([HP*8,switch_level-3*(i-2.5)])
        text(bankA[i],size=opisyBankowSize,halign="center",valign="center",spacing=1.1);
    translate([HP*8,switch_level+14])
    text(switch[1],size=3,halign="center",valign="center");
    //bank 2 slider opisy
    for(i=[0:5])
        translate([HP*12,switch_level-3*(i-2.5)])
        text(bankB[i],size=opisyBankowSize,halign="center",valign="center",spacing=1.1);
    translate([HP*12,switch_level+14])
    text(switch[0],size=3,halign="center",valign="center");
    //control slider opisy
    for(i=[0:5])
        translate([HP*4-2,switch_level-3*(i-2.5)])
        text(control[i],size=opisyBankowSize,halign="center",valign="center",spacing=1.1);
    //control slider napis
    translate([HP*3+5.25/2-dodatek/2,switch_level+14])
    text("FILL",size=3,halign="center",valign="center",spacing=1.1);
    //bank switch napisy
    for(i=[0,1])
        translate([HP*2,higher_element-8+8*2*i])
        text(switch[i],size=3,halign="center",valign="center");
    /*translate([HP*2-5,higher_element])
    text("BANK",size=3,halign="center",valign="center",direction="ttb");*/
    //napisy pod atenuvertery
    for(i=[0:3])
    translate([HP*(2+4*i),lower_element])
    {
        if(i!=0)
            translate([0,-12])
            text("CV",size=3,halign="center",valign="center",spacing=1.1);
        else
            translate([0,-12])
            text("GAIN",size=3,halign="center",valign="center",spacing=1.1);
        opis_atenuv(i);
        opis_galek(i);
    }
    //napisy pod parametrowe galki
    for(i=[0:2])
    translate([HP*(2+4+4*i),higher_element])
    {
        translate([0,-12])
        text(param[i],size=3,halign="center",valign="center");
        opis_galek(0);
    }
   
   
    //kreski
    translate([HP*(2+4*3)+0.7,lower_element-14])
    color("white")
    rotate(-83)
    square([5,0.5],false);
   
    translate([HP*(2+4*2)+1,lower_element-14])
    color("white")
    rotate(-57)
    square([7,0.5],false);
   
    translate([HP*(2+4)+2,lower_element-14])
    color("white")
    rotate(-45)
    square([9,0.5],false);
   
    difference()
    {
    for(x=[0:4])
        {
        translate([16/5*HP*(0.5+x),15,0])
        square([9,9],true);
        }
    }
    //opisy jackow out
    for(i=[0:1])
    {
    translate([16/5*HP*(i+1)-3.2,15])
    text(lower_jacks[i],size=2,halign="left",valign="center");
    //opisy jackow in
    translate([16/5*HP*(i+1)-3.2,26])
    text(higher_jacks[i],size=2,halign="left",valign="center");
    }
   
   
    for (i=[2:4])
    {
    //linie jacki in-out
    translate([16/5*HP*(0.5+i),21,0])
            square([0.5,4],true);  
    }
    //TESTS
   
    NOA_text=["NoiseOfAntimatter", "Noise Of Antimatter", "Noise of Antimatter", "NOA", "NoA"];
    NOA_nr=0;
    SSH_text=["SSH", "SubShaper"];
    SSH_nr=1;
    SSH_size=[3.3,4.5];
    Pozycjonowanie=1;


    if (Pozycjonowanie==0){
       
        SSH_offset=[0,-HP-2];

        color("white")
        translate([8*HP+SSH_offset[SSH_nr],121,0])
        text(SSH_text[SSH_nr], halign="center", size=SSH_size[SSH_nr], font=SSH_font);
   
        color("white")
        translate([11*HP+2,117,0])
        import(file = "Logo.svg", dpi = 900);

        color("white")
        translate([8*HP,4,0])
        text(NOA_text[NOA_nr],halign="center", size=3.3);
}
else if (Pozycjonowanie==1){
NOA_size=[3.3, 3.3, 3.3, 3.3, 3.3];
NOA_offset=[-5,-3, -3, -1.5, -1.5];
   
   
color("white")
translate([8*HP,121,0])
text(SSH_text[SSH_nr],font=SSH_font, halign="center", size=SSH_size[SSH_nr]);

color("white")
translate([8*HP+NOA_offset[NOA_nr],3,0])
text(NOA_text[NOA_nr],halign="center", size=3.3);

color("white")
translate([11.5*HP-3,1,0])
import(file = "Logo.svg", dpi = 1200);
}

translate([4,61])
obwodka([6*HP-dodatek-5+0.5,5+25],3,0.5);
translate([8*HP-6,61])
obwodka([2*6,30],3,0.5);
translate([12*HP-6,61])
obwodka([2*6,30],3,0.5);

}

projection(false)
translate([0,0,-0.01])
difference()
{
    union()
    {
        //color("black")
        //panel(16);
        color("white")
        napisy();
    }
    //elementy_sub(true);
}
//elementy_sub(false);

/*DFR=9.2;
color("red")
translate([-HP,DFR,4])
cube([18*HP,0.2,0.1]);
color("red")
translate([-HP,128.5-DFR,4])
cube([18*HP,0.2,0.1]);*/
