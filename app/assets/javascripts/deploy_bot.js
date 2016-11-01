var recording = false;
var speech_event = {};

var message_received = function(text){
  var msg = new SpeechSynthesisUtterance(text);
  window.speechSynthesis.speak(msg);

  msg.onend = function(){
    $("#output").css("color", "#6f6f6f")
  };
}

$(document).ready(function(){
  $("#mic").hover(
    function() {
      if (!recording) {
        $(".mic_off").hide();
      }
    },
    function() {
      if (!recording) {
        $(".mic_off").show();
      }
    }
  );
  $("#mic").click(function(){
    if (!recording) {
      recording = true;
      $("#output").text("")
      $("#output").css("color", "#ebebeb")
      $(".mic_hover").hide();
      recognition.start();
    }
  });

  var recognition = new webkitSpeechRecognition();
  recognition.interimResults = true;
  recognition.onresult = function(event) {
    speech_event = event;
    var output = event.results[0][0].transcript

    console.log(event);
    console.log(output);
    $("#output").text(output);

    if (event.results[0].isFinal) {
      recording = false;
      $(".mic_on").show();
      $(".mic_hover").show();
      App.deployment.deploy(output);
    }
  }
});
