//@author Matthew O
var lastSessionEvent = { "session_id":null, "behavior_square_id":null, "index": 0};
var sessionEvents = [];
window.onload = function () {
  //Add JAlert prompt http://labs.abeautifulsite.net/archived/jquery-alerts/demo/
  
  //Start time of the session
  var startTime = document.getElementById("start_time");
  startTime.innerHTML = "Start Time: " + timeOnlyStamp();
  document.getElementById("start").value = timeStamp();
  document.getElementById("start2").value = timeStamp();
  //Creates all the objects for duration behaviors
  var durationDivs = document.getElementsByClassName("duration");
  var timerSquares = [];
  for (var i = 0; i < durationDivs.length; i++)
  {
	  var timerSquare = new Object();
	  timerSquare.type = "duration";
	  timerSquare.startEventTime;
	  timerSquare.endEventTime;
	  timerSquare.Interval; //Interval for the timer not to be confused with an interval behavior sq
	  timerSquare.behaviorId = $(durationDivs[i]).attr('name');
	  timerSquare.undone = false;
	  timerSquare.durationLog =  document.getElementById("eventLog");
	  timerSquare.buttonStart =  durationDivs[i].querySelector((".button-start"));
	  timerSquare.secondsTxt = durationDivs[i].querySelector("#seconds");
	  timerSquare.minutesTxt = durationDivs[i].querySelector("#minutes");
	  timerSquare.seconds = 00;
	  timerSquare.minutes = 00;
	  timerSquares.push(timerSquare);
  }
  
  //Attaches event handler for all the timer buttons
  for(var i = 0; i < timerSquares.length; i++)
  {
	  ts = timerSquares[i];
	  timerSquares[i].buttonStart.onclick = beginTimer.bind(this, ts);
  }  

  //Creates all the objects for frequency behaviors
  var counterDivs = document.getElementsByClassName("frequency");
  var counterSquares = [];
  for (var i = 0; i < counterDivs.length; i++)
  {
	  var counterSquare = new Object();
	  counterSquare.type = "frequency";
	  counterSquare.startEventTime;
	  counterSquare.endEventTime;
	  counterSquare.behaviorId = $(counterDivs[i]).attr('name');
	  counterSquare.undone = false;
	  counterSquare.countLabel =  counterDivs[i].querySelector(".count");
	  counterSquare.countLog = document.getElementById("eventLog");
	  counterSquare.countButton =  counterDivs[i].querySelector((".counter"));	  
	  counterSquares.push(counterSquare);
  }
  
  //Attaches event handler for all the frequency buttons
  for(var i = 0; i < counterSquares.length; i++)
  {
	  cs = counterSquares[i];
	  counterSquares[i].countButton.onclick = count.bind(this, cs);
  }
  
  //Creates all the objects for interval behaviors
  var intervalDivs = document.getElementsByClassName("interval");
  var intervalSquares = [];
  for (var i = 0; i < intervalDivs.length; i++)
  {
	  var intervalSquare = new Object();
	  intervalSquare.type = "interval";
	  intervalSquare.startEventTime;
	  intervalSquare.endEventTime;
	  intervalSquare.behaviorId = $(intervalDivs[i]).attr('name');
	  intervalSquare.undone = false;
	  intervalSquare.countLabel =  intervalDivs[i].querySelector(".count");
	  intervalSquare.countLog = document.getElementById("eventLog");
	  intervalSquare.countButton =  intervalDivs[i].querySelector((".counter"));	  
	  intervalSquares.push(intervalSquare);
  }
  
  //Attaches event handler for all the interval buttons
  //Uses same handler as frequency
  for(var i = 0; i < intervalSquares.length; i++)
  {
	  interval = intervalSquares[i];
	  intervalSquares[i].countButton.onclick = count.bind(this, interval);
  }
 
  //Handler for frequency and interval behaviors
  function count(cs)
  {
	  cs.countLabel.innerText = (parseInt(cs.countLabel.innerText) + 1);  
	  cs.startEventTime = timeStamp();
	  cs.endEventTime = timeStamp();
	  createSessionEvent(cs);
	  logEvent(cs);
  }

  //Starts the timer
  function beginTimer(timerSq) 
  {
    clearInterval(timerSq.Interval);
	  timerSq.Interval = setInterval(function(){startTimer(timerSq)}, 1000);
	  //After timer starts next click will stop the timer
	  timerSq.buttonStart.onclick = function(){stopTimer(timerSq)};
	  timerSq.startEventTime = timeStamp();
	 
  }
  
  //End the timer and call method to send to the database
  function stopTimer(timerSq)
  {
    clearInterval(timerSq.Interval);
	  timerSq.durationLog.innerHTML += timerSq.minutesTxt.innerHTML + ":" + timerSq.secondsTxt.innerHTML +  "," + timeStamp() + "\n" ;
	  timerSq.endEventTime = timeStamp();
	  createSessionEvent(timerSq);
	  logEvent(timerSq);
	  resetTimer(timerSq);
	  //Reset the onclick to start the timer
	  timerSq.buttonStart.onclick = function(){beginTimer(timerSq)};
  }
  
  //Reset the timer fields
  function resetTimer(timerSq)
  {
     clearInterval(timerSq.Interval);
  	 timerSq.seconds = "00";
	   timerSq.minutes = "00";
  	 timerSq.secondsTxt.innerHTML = timerSq.seconds;
	   timerSq.minutesTxt.innerHTML = timerSq.minutes;
  }
  
   
  //Actual timer method: called every second when a timer is running
  function startTimer (timerSq)
  {
	  var seconds = timerSq.seconds;
	  var minutes = timerSq.minutes;
    seconds++;
    if(seconds <  10)
    {
      timerSq.secondsTxt.innerHTML = "0" + seconds;
    }
    if (seconds > 9)
	  {
      timerSq.secondsTxt.innerHTML = seconds;
    }
	  if(seconds > 59)
	  {
		  minutes++;
		  timerSq.minutesTxt.innerHTML = minutes;
		  seconds = 0;
		  timerSq.secondsTxt.innerHTML = "0" + 0;
	  }
	  timerSq.seconds = seconds;
	  timerSq.minutes = minutes;
  }

}
//Time stamp with a date
function timeStamp() {
// Create a date object with the current time
  var now = new Date();

// Create an array with the current month, day and time
  var date = [now.getFullYear(), now.getMonth() + 1, now.getDate()];

// Create an array with the current hour, minute and second
  var time = [ now.getHours(), now.getMinutes(), now.getSeconds() ];

// Determine AM or PM suffix based on the hour
  var suffix = ( time[0] < 12 ) ? "AM" : "PM";


// If seconds and minutes are less than 10, add a zero
  for ( var i = 1; i < 3; i++ ) {
    if ( time[i] < 10 ) {
      time[i] = "0" + time[i];
    }
  }

// Return the formatted string
  return date.join("/") + " " + time.join(":") + " " + suffix;

}
//Only includes the time in the time stamp
function timeOnlyStamp() {
// Create a date object with the current time
  var now = new Date();
  var time = [ now.getHours(), now.getMinutes()];
// Determine AM or PM suffix based on the hour
  var suffix = ( time[0] < 12 ) ? "AM" : "PM";
// Convert hour from military time
  time[0] = ( time[0] < 12 ) ? time[0] : time[0] - 12;
// If hour is 0, set it to 12
  time[0] = time[0] || 12;
// If seconds and minutes are less than 10, add a zero
  for ( var i = 1; i < 3; i++ ) {
    if ( time[i] < 10 ) {
      time[i] = "0" + time[i];
    }
  }
// Return the formatted string
  return time.join(":") + " " +suffix;

}
//Posts the session event to the database
function createSessionEvent(sessionEvent)
{
    
		$.ajax({
        url:'/session_events',
        type:'POST',
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        dataType:'json',
        data:{
             behavior_id: sessionEvent.behaviorId,
             start_time: sessionEvent.startEventTime,
             end_time: sessionEvent.endEventTime,
             session_id: getSessionId()
        },
        success:function(data){
        },
        error:function(data){
        }
    });
}

//Gets the session id from the url
function getSessionId(sessionEvent)
{
  url = window.location.href;
  number = parseInt(url.match(/(\d+)$/g));
	return number;
}

//Set the end session time
function getEndTime()
{
  document.getElementById("end").value = timeStamp();
  document.getElementById("end2").value = timeStamp();
  return true;
}

//Keep track of all the events that happened and update the last event
function logEvent(sessionEvent)
{
 
  lastSessionEvent.session_id = getSessionId(sessionEvent);
  lastSessionEvent.behavior_square_id =  sessionEvent.behaviorId;
  lastSessionEvent.index = sessionEvents.length;
  lastSessionEvent.sessionEvent = sessionEvent;
  
  var evt = { "session_id":null, "behavior_square_id":null, "index": -1};
  evt.session_id = getSessionId(sessionEvent);
  evt.behavior_square_id =  sessionEvent.behaviorId;
  evt.sessionEvent = sessionEvent;
  evt.index = sessionEvents.length;
  
  sessionEvents.push(evt);
  $('#eventLog').append(JSON.stringify(lastSessionEvent));
}

//Allows for undoing the last session event
function undo()
{
    //Handles async issues, last session event could change while undoing this event
    sessionEventUndo = lastSessionEvent;
  
    //Make them confirm they want to undo
    $.confirm({
			title: 'Undo:',
			content: '' +
			'<form action="" class="formName">' +
			'<div class="form-group">' +
			'<label>This will undo the last session event and cannot be undone</label>' +
			'</div>' +
			'</form>',
			buttons: {
				formSubmit: {
					text: 'Submit',
					btnClass: 'btn-blue',
					action: function () {
						//send the note
						$.ajax({
                url:'/session_events/undo',
                type:'POST',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                dataType:'json',
                data:{
                     behavior_square_id: lastSessionEvent.behavior_square_id,
                     session_id: lastSessionEvent.session_id
                },
                success:function(data){
                  sessionEvents[sessionEventUndo.index].undone = true; //mark it's been undone
                  //decrement the count on the front end if a count is connected
                  if(sessionEvents[sessionEventUndo.index].sessionEvent.type == "interval" || sessionEvents[sessionEventUndo.index].sessionEvent.type == "frequency")
                  {
                     if(parseInt(sessionEvents[sessionEventUndo.index].sessionEvent.countLabel.innerText) != 0)
                     {
                        sessionEvents[sessionEventUndo.index].sessionEvent.countLabel.innerText = (parseInt(sessionEvents[sessionEventUndo.index].sessionEvent.countLabel.innerText) - 1);  
                     }
                  }
                  //go to the next session event that hasn't been undone
                  for(var i = sessionEvents.length-1; i >= 0; --i)
                  {
                      if(!sessionEvents[i].undone)
                      {
                        lastSessionEvent.behavior_square_id =  sessionEvents[i].behavior_square_id;
                        lastSessionEvent.index = sessionEvents[i].index;
                        lastSessionEvent.sessionEvent = sessionEvents[i].sessionEvent;
                        break;
                      }
                  }
                },
                error:function(data){
                }
            });
					}
				},
				cancel: function () {
					//close
				},
			},
			onContentReady: function () {
				// you can bind to the form
				var jc = this;
				this.$content.find('form').on('submit', function (e) { // if the user submits the form by pressing enter in the field.
					e.preventDefault();
					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});
			}
		});
}