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
var i = 0.08;
var tri = {
  obj: {
    num: 25,
    step: Math.PI /90,
    rad: 130
  },

  draw_: function($) {
    $.globalCompositeOperation = 'lighter';
    //triangles
    $.beginPath();
    $.strokeStyle = 'hsla(' + i % 360 + ', 100%, 50%,1)';
    $.lineWidth = 3;
    $.moveTo(10, 10);
    $.lineTo(110, 37);
    $.lineTo(37, 110);
    $.closePath();
    $.stroke();
    //particles
    for (var n = 0; n < 10; ++n) {
      $.beginPath();
      $.rotate(30);
      $.fillStyle = 'hsla(' + 38 + ', 100%, 50%,1)';
      $.arc(-84, -84, 2, 0, Math.PI * 2);
      $.closePath();
      $.fill();

      $.beginPath();
      $.rotate(-90);
      $.fillStyle = 'hsla(' + 172 + ', 100%, 50%,1)';
      $.arc(104, 104, 2, 0, Math.PI * 2);
      $.closePath();
      $.fill();
    }
    //inner rectangles
    $.fillStyle = 'hsla(' + 34 + i % 15 + ', 100%, 40%,1)';
    $.rotate(90);
    $.lineWidth = 1.5;
    $.fillRect(20, 20, 20, 24);
    $.fill();
    //outer rectangles
    $.fillStyle = 'hsla(' + 37 + ', 100%, 50%,1)';
    $.lineWidth = 1.5;
    $.fillRect(115, 115, 24, 30);
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
  }, t, Math.PI * i * 2));
}

var go = function() {
  $.save();

  $.fillStyle = 'hsla(0,0%,0%,.4)';
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