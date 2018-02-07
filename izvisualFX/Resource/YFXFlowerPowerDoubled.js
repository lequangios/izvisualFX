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
    num: 10,
    step: Math.PI / 90,
    rad: 190
  },

  draw_: function($) {
    var rot = Math.sin(15) * 20 + 5;
    $.beginPath();
    $.fillStyle = 'hsla(' + i * 2 + ', 80%, 50%,1)';
    $.arc(-110, 110, 1, 0, Math.PI * 3);
    $.closePath();
    $.fill();
    for (var n = 0; n < 10; ++n) {
      $.beginPath();
      $.rotate(rot);
      $.fillStyle = 'hsla(' + i * 5 + ', 80%, 50%,1)';
      $.arc(105, -105, 2, 0, Math.PI * 5);
      $.closePath();
      $.fill();

      $.beginPath();
      $.rotate(-360);
      $.fillStyle = 'hsla(' + i + ', 80%, 50%,1)';
      $.fillRect(4, 4, 15, 15);
      $.closePath();
      $.fill();
    }
    $.fillStyle = 'hsla(' + i * 8 + ',80%, 40%,1)';
    $.rotate(rot);

    $.arc(115, -115, 5, 0, Math.PI * 2);
    $.fill();
    $.fillStyle = 'hsla(' + i * 12 + ', 100%, 50%,1)';
    $.arc(-100, 100, 4, 0, Math.PI * 2);
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
  }, t, Math.PI * 5 * i + 2));
}

var go = function() {
  $.save();

  $.fillStyle = 'hsla(0,0%,0%,.18)';
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