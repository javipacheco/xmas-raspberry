w = 1; 

deepTree = 50;

heightTop = 55;
height = 45;
heightBase = 30;
widthTop = 40;
widthMiddle = 55;
widthBottom = 65;
widthBase = 40;

module base_tree() {
    
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

module line(p1,p2,w) {
    hull() {
        translate(p1) circle(r=w,$fn=20);
        translate(p2) circle(r=w,$fn=20);
    }
}

module polyline(points, index, w) {
    if(index < len(points)) {
        line(points[index - 1], points[index],w);
        polyline(points, index + 1, w);
    }
}

module imanSupport() {
    difference() {
        cube([12, 12, deepTree], center=false);
        translate([6, 6, deepTree-0.5]) cylinder(h=2, r=4.4);
    }
}

module half_tree() {
    poly_tree = [
        [0,  heightTop * 2],
        [widthTop / 4,  heightTop * 2],
        [widthTop,  height],
        [widthMiddle / 2,  height],
        [widthMiddle,  0],
        [widthBottom / 1.5, 0],
        [widthBottom,  -height],
        [widthBottom / 1.5,  0],
        [widthBottom,  -height],
        [widthBase / 1.5,  -height],
        [widthBase,  -height - heightBase],
        [0,  -height - heightBase]
    ];
    polyline(poly_tree,1,w);
}

module full_tree() {
    half_tree();
    mirror([1,0,0]) half_tree();
}

difference() {
    base_tree();
     translate([22, -65, -2]) cylinder(h=5, d=12);
}

linear_extrude(deepTree) 
full_tree();

translate([-5, -75, 0]) imanSupport();

translate([-5, 98, 0]) imanSupport();