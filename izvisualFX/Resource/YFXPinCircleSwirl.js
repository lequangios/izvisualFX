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
c.width = window.innerWidth;
c.height = window.innerHeight;

var $ = c.getContext('2d');
var i = 0;
var tri = {
  obj: {
    num: 20,
    step: Math.PI / 90,
    rad: 130
  },
 
  draw_: function($) {
     $.globalCompositeOperation = 'lighter';
   var rot = Math.cos(5) * 2 + Math.sin(5) * 2;
    $.beginPath();
    $.fillStyle = 'hsla(' + i + ', 80%, 50%,1)';
    $.arc(100,100, 1, 0, Math.PI*2);
    $.closePath();
    $.fill();
    for (var n = 0; n < 8; ++n) {
      $.beginPath();
      $.rotate(rot);
      $.fillStyle = 'hsla(' + i * 2 + ', 80%, 50%,1)';
      $.arc(15, 15, 2, 0, Math.PI * 2);
      $.closePath();
      $.fill();

      $.beginPath();
      $.rotate(rot);
      $.fillStyle = 'hsla(' + i * 3 + ', 80%, 50%,1)';
      $.arc(5, 5, 1,0, Math.PI*2);
      $.closePath();
      $.fill();
    }
    $.fillStyle = 'hsla(' + i * 4 + ',80%, 40%,1)';
    $.rotate(rot);

    $.arc(60, 60,2, 0, Math.PI*2);
    $.fill();
    $.fillStyle = 'hsla(' + i * 5 + ', 100%, 50%,1)';
    $.arc(120, 120, 2, 0, Math.PI*2);
    $.fill();

  }
};

function Obj(mid, off_, step) {
  this.mid = mid;
  this.off_ = off_;
  this.step = step;
}

Obj.prototype.draw = function($) {
  this.step += tri.obj.step;
  $.save();
  $.translate(this.mid.x, this.mid.y);
  $.rotate(this.step + this.off_);
  tri.draw_($);
  $.restore();

};

var arr = [];
for (var i = 0; i < tri.obj.num; i++) {

  var t = i * Math.PI * 2 / tri.obj.num;
  arr.push(new Obj({
    x: c.width / 2 + tri.obj.rad * Math.cos(t),
    y: c.height / 2 + tri.obj.rad * Math.sin(t)
  }, t, Math.PI * i * 5));
}

var go = function() {
  $.save();
  $.fillStyle = 'hsla(0,0%,0%,.1)';
  $.fillRect(0, 0, c.width, c.height);

  for (var i in arr) {
    arr[i].draw($);
  }
  $.restore();
}

var run = function() {
  window.requestAnimFrame(run);
  go();
  i -= .5;
}

window.addEventListener('resize', function() {
  c.width = window.innerWidth;
  c.height = window.innerHeight;
}, false);

run();