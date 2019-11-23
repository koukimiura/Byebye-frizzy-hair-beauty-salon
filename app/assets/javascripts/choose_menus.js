$(document).ready(function() {

    $(document).on('change','input:checkbox', function() {
        
        //金額合計と時間
        price = [];
        required_time = [];
        
        //checkboxがcheckされているかどうか//
        $('input[name="menus[]"]:checked').each(function() {
            //文字列を整数に直す valueを取得//
            var number= parseInt($(this).attr('data-price'));
            var time = parseInt($(this).attr('data-time'));
            //console.log(number);
            price.push(number);
            required_time.push(time);
        });
    
        //過去に選択されたpriceが合算に影響を与えないように0を入れる。
        var total_Price = 0; //parseInt($('#totalPrice').attr('price'));  <-これでやってたから一度選択された値がたされていた。
        for (var i=0, len = price.length; i < len; i++) {
            total_Price += price[i];
        }
        
        
        var total_Time = 0;
        for (var i=0, len =required_time.length; i < len; i++) {
            total_Time += required_time[i];
        }
        
        
        $("#totalPrice").attr('price', total_Price ).html('￥' + total_Price);
        $("#totalTime").attr('time', total_Time ).html(total_Time + '分');
        
        
        //選択されたメニューの表示
        if(this.checked){
            var $copy= $('#selectedMenu').clone().css('display', 'block');
                $copy.removeAttr('id');
                $copy.attr('id', 'selectedCheck'+$(this).val());
                var name = $(this).attr('data-name');
                var price= $(this).attr('data-price');
                var time = $(this).attr('data-time');
                
                
                $copy.find('#selected_Name').html(name);
                $copy.find("#selected_Price").html('￥' + price);
                $copy.find("#selected_Time").html(time + '分');
                $('#selectedMenu').after($copy);
                
        } else {
            //用事されているidを取得してremove();
            var target=$('#selectedCheck'+$(this).val());
            target.remove();
        }
    
    });
    
    
    // rubyのrenderだと@menusを保持したまま再表示するのが面倒だから
    $(document).on('click', '#submit-btn', function(){
        
        if($('#check').val() === ''){
            
            alert('メニューを洗濯してください。');
            return false;
        }
    });
    
    
});

