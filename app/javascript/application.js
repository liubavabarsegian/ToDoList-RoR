//Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"

var reminder = document.getElementById("toggle");
var reminder_time = document.getElementById("reminder_show");

reminder.addEventListener('change', function(){
    alert('aawqw')
    if (this.checked) {
        reminder_time.style.visibility='visible'
    }
    else {
        reminder_time.style.visibility='hidden'
    }
    
})

