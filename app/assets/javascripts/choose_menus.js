//読み込んだら
$(document).ready(function() {
    
    function comma(price, total_Price, number) {
        return String(price,total_Price,number).replace( /(\d)(?=(\d\d\d)+(?!\d))/g, '$1,');
    }
    
    
    if (window.performance.navigation.type === 0/* TYPE_NAVIGATE */) {
      // 初期表示
      
      
    } else if (window.performance.navigation.type === 1/* TYPE_RELOAD */) {
      // リロード
      
      //sessionStorage.removeItem();
        sessionStorage.clear(); //すべてのデータを削除
      
    } else {
        // リロードされていない
        
        let times = sessionStorage.getItem('array_time');
        let prices = sessionStorage.getItem('array_price');
        let array_menus = JSON.parse(sessionStorage.getItem('menus'));
        //let array_clones = sessionStorage.getItem('clonedMenu');

        $("#totalPrice").attr('price', prices).html('￥' + prices);
        $("#totalTime").attr('time', times).html(times + '分');
        
        //sessionStorage.clear()
        //console.log(times);
        //console.log(prices);

        //Uncaught TypeError: Cannot read propertyのエラー対策
        if (array_menus) {
            let i = 0;
            var Ids =[];
            while (i < array_menus.length){
                array_menus.forEach(function(menu){
                    
                    //== と ===は同じデータ型であれば　===が推奨される。しかも厳密な条件文。
                    //初回 copyで出力良くするのは良いが複数個メニューが選択された場合書き換えになっていますので条件文で出力
                    if (i === 0) {
                        var $copy = $('#selectedMenu').clone().css('display', 'block');
                        $copy.removeAttr('id');
                        
                        var Id = 'selectedCheck'+ (menu['value']);
                            
                        Ids.push(Id);
                        
                        $copy.attr('id', 'selectedCheck'+ (menu['value']));
                        $copy.find('#selected_Name').html(menu['nameKey']);
                        $copy.find("#selected_Price").html('￥' + menu['priceKey']);
                        $copy.find("#selected_Time").html(menu['timeKey'] + '分');
                        $('#selectedMenu').after($copy);
                        
                    } else {
                        
                        var $copy = $('#selectedMenu').clone().css('display', 'block');
                        $copy.removeAttr('id');
                        
                        var Id = 'selectedCheck'+ (menu['value']);
                        
                        
                        $copy.attr('id', 'selectedCheck'+ (menu['value']));
                        
                        $copy.find('#selected_Name').html(menu['nameKey']);
                        $copy.find("#selected_Price").html('￥' + menu['priceKey']);
                        $copy.find("#selected_Time").html(menu['timeKey'] + '分');
                        
                        console.log(Ids.pop());
                        
                        // 配列のケツの要素をとってきて、一個前にviewに出力したidの前に$copyを出力
                        $(Ids.pop()).before($copy);
                        
                        //月の配列要素が来たときのために最後にプッシュs
                        Ids.push(Id);
                    }
                });
            i ++;   
            }
        }
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
            
            //クローン出力
            $copy.find('#selected_Name').html(name);
            
            //クローン出力
            //正規表現comma(price)を使って3桁でカンマ入れる
            $copy.find("#selected_Price").html('￥' + comma(price));
            $copy.find("#selected_Time").html(time + '分');
            $('#selectedMenu').after($copy);
            
            
            
        } else {
            //用事されているidを取得してremove();
            var target=$('#selectedCheck'+$(this).val());
            target.remove();
        }
        
 
 
//----------------------------------------------------------------------------------

        //金額合計と時間
        
        var prices = [];
        var required_time = [];
        var array_hash_menus = [];
        var clones=[]
        
       
        //checkboxがcheckされているかどうか//
    
        $('input[name="menus[]"]:checked').each(function() { 

            //文字列を整数に直す  parseInt valueを取得
            var menuId = $(this).val();
            var name= $(this).attr('data-name');
            var number= parseInt($(this).attr('data-price'));
            var time = parseInt($(this).attr('data-time'));
            
            var clone = $(this).clone();
            
            //console.log(clone);
            //Ids.push(id);
            prices.push(number);
            required_time.push(time);
            clones.push(clone);
            
            // keyは文字列かシラブル、　valueは文字列が基本
            //array_hash_menus.push({ [i]: {"value": menuId, "nameKey": name, "priceKey": price, "timeKey": time}});
            
            //正規表現comma(price)を使って3桁でカンマ入れる
            array_hash_menus.push({"value": menuId, "nameKey": name, "priceKey": comma(number), "timeKey": time});
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
        
        //合計出力
        //正規表現comma(price)を使って3桁でカンマ入れる
        $("#totalPrice").attr('price', total_Price ).html('￥' + comma(total_Price));
        $("#totalTime").attr('time', total_Time ).html(total_Time + '分');
        
        //console.log(total_Time);
        //console.log(total_Price);
       // console.log(clones);
        
        // keyは文字列かシラブル、　valueは文字列が基本
        //menus_hash = {"value": Ids, "name": names, "price": prices, "time": required_time};


        //javascriptオブジェクトからjson化するメソッド
        //sessionStrageは文字列で渡さないといけない。
        var tojson = JSON.stringify(array_hash_menus);
        //var tojson_clones = JSON.stringify(clones);

        sessionStorage.setItem('array_time', total_Time);
        
        //正規表現comma(price)を使って3桁でカンマ入れる
        sessionStorage.setItem('array_price', comma(total_Price));
        sessionStorage.setItem('menus', tojson); 
        sessionStorage.setItem('clonedMenu', JSON.stringify(clones)); 

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
        
        
     });
     
});


