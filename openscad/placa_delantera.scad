
displX = 37;

dispToplY = 16;

displBottomY = 15;

displZ = 0;

stroke = 1;

dispZero = 30;

module lcd_tree() {
    difference() {
        tree();
        
        // lcd screen
        translate([0, 0, -2]) cube([72,24.33,15],center=true);    
        
        // led
        translate([25, 55, -2]) cylinder(h=5, d=5.7);
        
        // iman
        translate([0, 102, 0.5]) cylinder(h=5, r=4.4);
        translate([0, -68, 0.5]) cylinder(h=5, r=4.4);
        
    }
    
    // lcd holes
    translate([-displX, -displBottomY, displZ]) cylinder(h=8, d=2.2);
    translate([-displX, dispToplY, displZ]) cylinder(h=8, d=2.2);
    translate([displX, -displBottomY, displZ]) cylinder(h=8, d=2.2);
    translate([displX, dispToplY, displZ]) cylinder(h=8, d=2.2);
    
    // pi
    translate([-11.5, dispZero, displZ]) cylinder(h=5, d=2.2);
    translate([11.5, dispZero, displZ]) cylinder(h=5, d=2.2);
    translate([-11.5, 58 + dispZero, displZ]) cylinder(h=5, d=2.2);
    translate([11.5, 58 + dispZero, displZ]) cylinder(h=5, d=2.2);
    
}

module tree() {
    heightTop = 55;
    height = 45;
    heightBase = 30;
    widthTop = 40;
    widthMiddle = 55;
    widthBottom = 65;
    widthBase = 40;
    
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]]; // left

    CubePointsTop = [
      [  -widthTop,  height,  0 ],  //0
      [ widthTop,  height,  0 ],  //1
      [ widthTop / 4,  heightTop * 2,  0 ],  //2
      [  -widthTop / 4,  heightTop * 2,  0 ],  //3
      [  -widthTop,  height,  2 ],  //4
      [ widthTop,  height,  2 ],  //5
      [ widthTop / 4,  heightTop * 2,  2 ],  //6
      [  -widthTop / 4,  heightTop * 2,  2 ]]; //7
      
    polyhedron( CubePointsTop, CubeFaces );

    CubePointsMiddle = [
      [  -widthMiddle,  0,  0 ],  //0
      [ widthMiddle,  0,  0 ],  //1
      [ widthMiddle / 2,  height,  0 ],  //2
      [  -widthMiddle / 2,  height,  0 ],  //3
      [  -widthMiddle,  0,  2 ],  //4
      [ widthMiddle,  0,  2 ],  //5
      [ widthMiddle / 2,  height,  2 ],  //6
      [  -widthMiddle / 2,  height,  2 ]]; //7
      
    polyhedron( CubePointsMiddle, CubeFaces );

    CubePointsBottom = [
      [  -widthBottom,  -height,  0 ],  //0
      [ widthBottom,  -height,  0 ],  //1
      [ widthBottom / 1.5,  0,  0 ],  //2
      [  -widthBottom / 1.5,  0,  0 ],  //3
      [  -widthBottom,  -height,  2 ],  //4
      [ widthBottom,  -height,  2 ],  //5
      [ widthBottom / 1.5,  0,  2 ],  //6
      [  -widthBottom / 1.5,  0,  2 ]]; //7

    polyhedron( CubePointsBottom, CubeFaces );
    
    CubePointsBase = [
      [  -widthBase,  -height - heightBase,  0 ],  //0
      [ widthBase,  -height - heightBase,  0 ],  //1
      [ widthBase / 1.5,  -height,  0 ],  //2
      [  -widthBase / 1.5,  -height,  0 ],  //3
      [  -widthBase,  -height - heightBase,  2 ],  //4
      [ widthBase,  -height - heightBase,  2 ],  //5
      [ widthBase / 1.5,  -height,  2 ],  //6
      [  -widthBase / 1.5,  -height,  2 ]]; //7
    
    polyhedron( CubePointsBase, CubeFaces );
}

lcd_tree();
