// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function moveText(amount){
  target = document.querySelector("#articleDisplay");
  targetPosition = target.getAttribute("position");
  stepCount = 0
  var id = setInterval(frame, 5);
  function frame(){
    if (stepCount == 100) {
        clearInterval(id);
    } else {
        stepCount++; 
        target.setAttribute('position',{
          x: targetPosition.x,
          y: targetPosition.y + (amount/100 * stepCount),
          z: targetPosition.z
        });
    };
  };
}