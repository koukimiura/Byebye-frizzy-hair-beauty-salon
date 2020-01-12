
//読み込んだら
$(document).ready(function() {
    
    var times = sessionStorage.getItem('array_time');
    var prices = sessionStorage.getItem('array_price');
    var array_menus = JSON.parse(sessionStorage.getItem('menus'));
    console.log(times);
    console.log(prices);
    
    
    if (window.performance.navigation.type === 0/* TYPE_NAVIGATE */) {
      // 初期表示
      
      
    } else if (window.performance.navigation.type === 1/* TYPE_RELOAD */) {
      // リロード
      
      //sessionStorage.removeItem();
        sessionStorage.clear(); //すべてのデータを削除
      
    } else {
        // リロードされていない
        
        $("#totalPrice").attr('price', prices).html('￥' + prices);
        $("#totalTime").attr('time', times).html(times + '分');
        
        var $copy= $('#selectedMenu').clone().css('display', 'block');
        
        console.log(array_menus);
        //console.log(clonexxxx);
        
        //var i = 0;
        

        
        //while (i < array_menus.length) {
        //array_menus.forEach((menu) => {
        
        //$copy.attr('id', 'selectedCheck'+ menu['value']);
        //createdId.push('selectedCheck'+ menu['value']);
       // $copy.find('#selected_Name').html(menu[i]['nameKey']);
        //$copy.find("#selected_Price").html('￥' + menu[i]['priceKey']);
        //$copy.find("#selected_Time").html(menu[i]['timeKey'] + '分');
    
        
        //});
       ////// i ++;
        //}
        //$('#selectedMenu').after($copy);
        
      
    }

   




    $(document).on('change','input:checkbox', function() { 
        //選択されたメニューの表示
        if(this.checked){
            var $copy= $('#selectedMenu').clone().css('display', 'block');
            $copy.removeAttr('id');
                
            $copy.attr('id', 'selectedCheck'+$(this).val());
            
            var name = $(this).attr('data-name');
            var price= $(this).attr('data-price');
            var time = $(this).attr('data-time');
            
            //出力
            $copy.find('#selected_Name').html(name);
            $copy.find("#selected_Price").html('￥' + price);
            $copy.find("#selected_Time").html(time + '分');
            $('#selectedMenu').after($copy);
            
            
            //$(document).on('click', '#submit-btn', function(){
                
             //});
            
            
        } else {
            //用事されているidを取得してremove();
            var target=$('#selectedCheck'+$(this).val());
            target.remove();
        }
        
      
        //金額合計と時間
        
        //Ids = [];
        //names = [];
        prices = [];
        required_time = [];
        array_hash_menus = [];
        
       
        //checkboxがcheckされているかどうか//
        

        //while ( i < length) {
        $('input[name="menus[]"]:checked').each(function() { 
            //console.log($('input[name="menus[]"]:checked').length);

            //文字列を整数に直す  parseInt valueを取得    //
            var menuId = $(this).val();
            var name= $(this).attr('data-name');
            var number= parseInt($(this).attr('data-price'));
            var time = parseInt($(this).attr('data-time'));
            
            //Ids.push(id);
            //names.push(name);
            prices.push(number);
            required_time.push(time);
            
            // keyは文字列かシラブル、　valueは文字列が基本
            //array_hash_menus.push({ [i]: {"value": menuId, "nameKey": name, "priceKey": price, "timeKey": time}});
            array_hash_menus.push({"value": menuId, "nameKey": name, "priceKey": price, "timeKey": time});
            
        });
        
    
        //過去に選択されたpriceが合算に影響を与えないように0を入れる。//
        //parseInt($('#totalPrice').attr('price'));  <- これでやってたから一度選択された値が足されていた。//
        
        var total_Price = 0; 
        for (var i=0, len = prices.length; i < len; i++) {
            total_Price += prices[i];
        }
        
        
        var total_Time = 0;
        for (var i=0, len =required_time.length; i < len; i++) {
            total_Time += required_time[i];
        }
        
        //出力
        $("#totalPrice").attr('price', total_Price ).html('￥' + total_Price);
        $("#totalTime").attr('time', total_Time ).html(total_Time + '分');
        
        console.log(total_Time);
        console.log(total_Price);
        
        // keyは文字列かシラブル、　valueは文字列が基本
        //menus_hash = {"value": Ids, "name": names, "price": prices, "time": required_time};

        //javascriptオブジェクトからjson化するメソッド
        var tojson = JSON.stringify(array_hash_menus);

        sessionStorage.setItem('array_time', total_Time);
        sessionStorage.setItem('array_price', total_Price);
        sessionStorage.setItem('menus', tojson); 

   });



    //submitボタン
    // rubyのrenderだと@menusを保持したまま再表示するのが面倒だから
    $(document).on('click', '#submit-btn', function(){
        
        //lengthメソッドでチェックされているinputの数がわかる。
        if($('input[name="menus[]"]:checked').length === 0){
            //console.log($('input[name="menus[]"]:checked').length);
            
            alert('メニューを選択して下さい');
			return false;
        }
        
        
        
        
       // clonexxx=[]
        
       // $('input[name="menus[]"]:checked').each(function() { 
            //var $clone = $('#selectedCheck'+$(this).val()).clone();
            ///clonexxx.push($clone);
            
      //  });
        
        //console.log(clonexxx);
                    
        //sessionStorage.setItem('clone', JSON.stringify(clonexxx));             
                
     });
});


