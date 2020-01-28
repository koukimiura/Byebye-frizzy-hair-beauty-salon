$(document).ready(function(){
    
    //モーダルウィンドウ処理
    $('.open-modal').on('click', function(e){
        //linkの機能を無効
        e.preventDefault()
        
        let target =　$(this).data('target');
        let openModal = document.getElementById(target);
        
        //console.log(target);
        //console.log(openModal);
        
        // retun falseでモーダルが表示されてからすぐに非表示になるのを防ぐ    処理の中断
        $(openModal).fadeIn();
        return false; 
    });
    

    $(".close-btn").on("click", function(e){
        
        //aタグ、href＝”#"の機能を無効にしないと画面上部へとびモーダルを消す際に以前に開いたモーダルが一瞬出る。
        //linkの機能を無効
        e.preventDefault()
        
        let target = $(this).closest(".staff-show").attr("id");
        let closeModal = document.getElementById(target);
        $(closeModal).fadeOut();
    });
    
});
