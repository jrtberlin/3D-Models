$fn=90;

module espresso(length, width, thickness){
    holedist = 55;
difference(){
    translate([0,width/2,thickness/2])
    cube([length, width, thickness], center=true);
            union(){
            translate([14.8,holedist,0])
                cylinder(r=9, h=thickness);
            translate([-14.8,holedist,0]) 
                cylinder(r=9, h=thickness);
            }
    }
}
module edge(size,thickness,x,y){
    translate([-size,-size,0]){
    translate([x,y,0]){
        difference(){
            cube([size,size,thickness]);
            cylinder(r= size,h= thickness);
        }
    }
  }
}


module espressoplatte(length, width, thickness){
difference(){
espresso(length, width, thickness);
    union(){
    mirror() edge(60,8,length/2,width);
    edge(60,8,length/2,width);
    }
}
}

module cut(hi, wi, ti){
    union(){
    translate([0, wi/2, ti/2])
        cube([hi, wi, ti],center=true);
    translate([hi/2,wi/2,0])
        cylinder(r=wi/2,h=ti);
    translate([-hi/2,wi/2,0])
        cylinder(r=wi/2,h=ti);
    }
}

module cut2(hi,wi,ti,shrink){
    difference(){
        translate([0,wi/2,ti/2])
            cube([hi-shrink*2,wi-shrink*2,ti],center=true);
        
        union(){
            translate([-hi/2,0,ti-shrink])
                cube([hi,wi,shrink]);
            mirror() edge(60,8,hi/2-shrink,wi-shrink);
            edge(60,ti-shrink,hi/2-shrink,wi-shrink);
        }
    }
}




length  = 180;
width   = 115;
thickness= 8;
wall=2;

difference(){
espressoplatte(length, width, thickness);
    union(){
        translate([0,76,0])
            cut(20, 5,thickness); //passt
        translate([-41.25,59.75,0])
            cylinder(r=4.75,h=thickness);
        cut2(120,115,thickness,wall);
        translate([0,2.5,3])
            cube([115,5,6],center=true);
    }
}
