
function codeAddress(){
    let inputAddress = document.getElementById('stasion_name').value;

//入力値に""駅"が含まれなければ
    if (inputAddress.indexOf('駅') == -1) {
        inputAddress = inputAddress + '駅';
        document.getElementById('stasion_name').value = inputAddress;
    }

    marker.setMap(null);
    geocoder.geocode( { 'address': inputAddress}, function(results, status) {
        if (status == 'OK') {
            map.setCenter(results[0].geometry.location);
            marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location,
                draggable: true
        });
        //display.textContent = "検索結果：" + results[ 0 ].geometry.location
        var location = results[0].geometry.location;
        //DB登録用hidden項目にセット
        // document.getElementById('target_latitude').textContent = location.lat();
        // document.getElementById('target_longitude').textContent = location.lng();
        document.getElementById('topic_latitude').value = location.lat();
        document.getElementById('topic_longitude').value = location.lng();
        } else {
            alert('該当する結果がありませんでした：' + status);
        }
        //マーカーのドロップ（ドラッグ終了）時のイベント
        google.maps.event.addListener(marker, 'dragend', function(e) {
        //イベントの引数eの、プロパティ.latLngがmarkerの緯度経度。
        // document.getElementById('target_latitude').textContent = e.latLng.lat(),
        // document.getElementById('target_longitude').textContent = e.latLng.lng()
        document.getElementById('topic_latitude').value = e.latLng.lat(),
        document.getElementById('topic_longitude').value = e.latLng.lng()
        });
    });

    // infoWindowは吹き出し
    infoWindow = new google.maps.InfoWindow({
        // contentで中身を指定
        // 今回は文字にリンクを貼り付けた形で表示
        content: `<a href='/pages/index'>リンクです！</a>`
    });
    // markerがクリックされた時、
    marker.addListener("click", function(){
        // infoWindowを表示
        infoWindow.open(map, marker);
    });
        //マーカーのドロップ（ドラッグ終了）時のイベント
        google.maps.event.addListener(marker, 'dragend', function(e) {
            //イベントの引数eの、プロパティ.latLngがmarkerの緯度経度。
            // document.getElementById('target_latitude').textContent = e.latLng.lat(),
            // document.getElementById('target_longitude').textContent = e.latLng.lng()
            document.getElementById('topic_latitude').value = e.latLng.lat(),
            document.getElementById('topic_longitude').value = e.latLng.lng()
        });
}

//最寄駅オートコンプリート
$( function() {
        $("#stasion_name").autocomplete({
        autoFocus: true,
        source: "/topics/topics/auto_complete.json",
        minLength: 1,
    });
});

//入力チェック
$(function(){
    var input_chk = "true"
    $("form").submit(function(){
        if ($("#topic_title").val() == ""){
            $("#topic_title").css("border","1px solid red")
            alert("タイトルを入力してください。");
            input_chk = "false";
        }else {input_chk = "true";}

        if ($("#stasion_name").val() == ""){
            $("#stasion_name").css("border","1px solid red")
            alert("最寄駅を入力してください。");
            input_chk = "false";
        }else {input_chk = "true";}
    if (input_chk == "false"){return false;}
    });
});

//画像プレビュー1
$(function(){
    $fileField = $('#form-picture1')

    $($fileField).on('change', $fileField, function(e) {
        alert("gazo!");
        file = e.target.files[0]
        reader = new FileReader(),
        $preview = $('#img_field1');

        reader.onload = (function(file) {
            return function(e) {
                $preview.empty();
                $preview.append($('<img>').attr({
                    src: e.target.result,
                    width: "100%",
                    height: "100%",
                    class: "preview",
                    id: "preview1",
                    title: file.name
                }));
            };
        })(file);
        reader.readAsDataURL(file);
    });
});

//画像プレビュー2
$(function(){
    $fileField = $('#form-picture2')

    $($fileField).on('change', $fileField, function(e) {
        file = e.target.files[0]
        reader = new FileReader(),
        $preview = $('#img_field2');

        reader.onload = (function(file) {
            return function(e) {
                $preview.empty();
                $preview.append($('<img>').attr({
                    src: e.target.result,
                    width: "100%",
                    height: "100%",
                    class: "preview",
                    id: "preview2",
                    title: file.name
                }));
            };
        })(file);
        reader.readAsDataURL(file);
    });
});

//画像プレビュー3
$(function(){
    $fileField = $('#form-picture3')

    $($fileField).on('change', $fileField, function(e) {
        file = e.target.files[0]
        reader = new FileReader(),
        $preview = $('#img_field3');

        reader.onload = (function(file) {
            return function(e) {
                $preview.empty();
                $preview.append($('<img>').attr({
                    src: e.target.result,
                    width: "100%",
                    height: "100%",
                    class: "preview",
                    id: "preview3",
                    title: file.name
                }));
            };
        })(file);
        reader.readAsDataURL(file);
    });
});

//画像が投稿されたら、次の投稿フォームを表示
$(function(){
    $('#form-picture1').on('change', function (e) {
        if (e.target.files[0].size > 0) {
            $('.img_upload2').slideDown("slow");
        }
    });
    $('#form-picture2').on('change', function (e) {
        if (e.target.files[0].size > 0) {
            $('.img_upload3').slideDown("slow");
        }
    });
});


//写真削除ボタンメソッド
function del_img(number,pages) {
    var preview
    if (pages == 'new') {
        preview = document.getElementById('preview' + number);
    }else if (pages == 'edit'){
        preview = document.getElementById('preview' + number);
        //初期表示の場合
        if (preview === null) {
            preview = document.getElementById('img_' + number);
        }
    }
    preview.parentNode.removeChild(preview);
    var img_field_element = document.getElementById('img_field' + number);
    const img_f = document.createElement('i');
    img_f.classList.add('fas','fa-images');
    img_field_element.appendChild(img_f);
    var pic = document.getElementById('form-picture' + number);
    pic.value = "";

    if (pages == 'new'){
        if (number == '2') {
            $('.img_upload2').slideUp("slow");
        } else if (number == '3') {
            $('.img_upload3').slideUp("slow");
        }
    }
}


/****************
 * Serchアクション* 
 ****************/
//検索入力画面の初期表示(注意事項)
// $(function(){
//     $("#search").val("最寄駅を入力してください。").css("color","#CCC").one("focus",function(){
//         $(this).val("").css("color","#000");
//     }).blur(function(){
//         if($(this).val()==""){
//             $(this).val("○○駅と入力してください。").css("color","#CCC").one("focus",function(){
//                 $(this).val("").css("color","#000");
//             });
//         }
//     });
// });

//最寄駅オートコンプリート
$( function() {
        $("#inlineFormInputGroup").autocomplete({
        autoFocus: true,
        source: "/topics/topics/auto_complete.json",
        minLength: 1,
    });
});