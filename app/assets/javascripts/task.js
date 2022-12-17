var reminder = document.getElementById("toggle");
var reminder_time = document.getElementById("reminder_show");

reminder.addEventListener('change', function(){
    if (this.checked) {
        reminder_time.style.visibility='visible'
    }
    else {
        reminder_time.style.visibility='hidden'
    }
    
})
