window.requestAnimFrame = (function() {
  return window.requestAnimationFrame ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    window.oRequestAnimationFrame ||
    window.msRequestAnimationFrame ||
    function(callback) {
      window.setTimeout(callback, 1000 / 60);
    };
})();

var c = document.getElementById('canv');
var w = c.width = window.innerWidth / 1.5;
var h = c.height = window.innerHeight / 1.5;

window.addEventListener('resize', function() {
  c.width = w = window.innerWidth / 1.5;
  c.height = h = window.innerHeight / 1.5;
}, false);

var $ = c.getContext('2d');
var u;

var draw = function(ang, dst) {
  var rings = 34;
  /*******************
  //play with the below 'u' var value 
  for color variations. 
  (any num from 2-360)
  *************************/
  u = -7;
  for (var i = 0; i < rings; i++) {
    spc = Math.pow(1.2, (i + 1))
    sd = spc + dst * spc * 1.1;
    x = w / 2 + Math.cos(ang) * sd;
    y = h / 2 + Math.sin(ang) * sd;
    s = sd / 10;
    $.globalCompositeOperation = 'difference';
    $.fillStyle = "hsla(" + (i / u * 360) + ",100%, 30%, 1)"
    $.beginPath();
    $.arc(x, y, s * 3.2, 0, Math.PI * 2);
    $.fill();
  }
}
a = 0;

var go = function() {
  $.clearRect(0, 0, w, h);
  a++;
  var circs = 25;
  var v = 0;

  for (var i = 0; i < circs; i++) {
    ang = a / 500 + i / circs * Math.PI * 2;
    dst = v + (Math.sin(5 * i / circs * Math.PI * 5) +
      2 + Math.sin(a / 2 + 5 * i / circs * Math.PI * 2) + 25) / 2;
    draw(ang, dst);
  }
  window.requestAnimFrame(go);
}
go()