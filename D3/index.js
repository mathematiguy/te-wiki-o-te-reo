function PinchZoom(selection, zoom){
    
    if(!zoom) throw "zoom must be passed as a second argument";
    
    var isMac = navigator.platform.toUpperCase().indexOf('MAC')>=0;
    if(!isMac) return;

    selection
        .on('wheel.zoom', wheeled)
        .on('gesturechange', gestured)
        .on('gesturestart', gesturestart)
        .on('gestureend', gestured);

    function wheeled(){
        var e = d3.event;
        e.preventDefault()
        
        if(e.metaKey || e.ctrlKey){
            // on Chrome, pinch-zoom maps to Ctrl+Scroll
            zoom.scaleBy(selection, Math.pow(0.98, e.deltaY))
        } else {
            // Scroll to pan
            var scale = d3.zoomTransform(selection.node()).k;
            zoom.translateBy(selection, -e.deltaX / scale, -e.deltaY / scale)
        }
    }

    var initialScale = 1;
    function gesturestart(){
        // Safari uses their weird gesturestart/gestureend to zoom trick
        initialScale = d3.zoomTransform(selection.node()).k;
        d3.event.preventDefault()
    }

    function gestured(){
        var e = d3.event;
        zoom.scaleTo(selection, e.scale * initialScale)
        e.preventDefault()
    }
}

if(typeof exports === "object" && exports) {  
    module.exports = PinchZoom;
}

function getTransformation(transform) {
  // Create a dummy g for calculation purposes only. This will never
  // be appended to the DOM and will be discarded once this function 
  // returns.
  var g = document.createElementNS("http://www.w3.org/2000/svg", "g");
  
  // Set the transform attribute to the provided string value.
  g.setAttributeNS(null, "transform", transform);
  
  // consolidate the SVGTransformList containing all transformations
  // to a single SVGTransform of type SVG_TRANSFORM_MATRIX and get
  // its SVGMatrix. 
  var matrix = g.transform.baseVal.consolidate().matrix;
  
  // Below calculations are taken and adapted from the private function
  // transform/decompose.js of D3's module d3-interpolate.
  var {a, b, c, d, e, f} = matrix;   // ES6, if this doesn't work, use below assignment
  // var a=matrix.a, b=matrix.b, c=matrix.c, d=matrix.d, e=matrix.e, f=matrix.f; // ES5
  var scaleX, scaleY, skewX;
  if (scaleX = Math.sqrt(a * a + b * b)) a /= scaleX, b /= scaleX;
  if (skewX = a * c + b * d) c -= a * skewX, d -= b * skewX;
  if (scaleY = Math.sqrt(c * c + d * d)) c /= scaleY, d /= scaleY, skewX /= scaleY;
  if (a * d < b * c) a = -a, b = -b, skewX = -skewX, scaleX = -scaleX;
  return {
    translateX: e,
    translateY: f,
    rotate: Math.atan2(b, a) * 180 / Math.PI,
    skewX: Math.atan(skewX) * 180 / Math.PI,
    scaleX: scaleX,
    scaleY: scaleY
  };
}
