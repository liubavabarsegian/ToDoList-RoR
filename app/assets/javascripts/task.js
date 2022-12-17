$(function () {
    
    $("#reminder").click(function () {
        if ($(this).is(":checked")) {
            alert("hey")
            $("#reminder_show").show();
            // $("#AddPassport").hide();
        } else {
            $("#reminder_show").hide();
            // $("#AddPassport").show();
        }
    });
});