    $(document).ready(function(){
        var interval = setInterval(function () {
            var h = $(".main_col").height();
            $(".left_col").height(h);
            clearInterval(interval);
        }, 100);

    });