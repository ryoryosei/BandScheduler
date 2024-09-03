<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BandSchedulerの使い方！</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="css/usage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@include file="header.jsp"%><br>
	
	<div class="container mt-5">
        <div class="text-center">
        	<h2>BandSchedulerの使い方！</h2><br>
        	<p>ミセスのコピーバンドを例として説明します！ バンドIDは「mga」にしました。</p><hr><br>
        	
        	
        <details class="details">
        	<summary class="details-summary">1.予定の登録</summary>
        	
        	<div class="details-content">
	        	<p>新しく予定を登録したいときは登録ボタンを押します。</p><br>
				<p><img src="img/01.png" width="300" height="250"  alt="写真"</p><br><br>
				
				<p>どの期間の予定を登録するかを入力して「次へ」を押します。</p><br>
				<p><img src="img/02.png" width="300" height="350"  alt="写真"</p><br><br>
				
				<p>期間を選んだら、登録する人の名前（今回はmember01）と、練習可能な日時にチェックを入れて送信します。</p>
				<p>同じ名前の予定がすでにある場合、その予定を上書きしてしまうため、名前がかぶらないよう注意してください！</p><br>
				<p><img src="img/03.png" width="300" height="300"  alt="写真"</p><br><br>
				
				<p>送信ボタンを押すとホーム画面に戻り、「登録しました」というメッセージが表示されます。</p>
				<p>登録した予定を確認したいときは確認ボタンを押します。<p><br>
				<p><img src="img/04.png" width="300" height="300"  alt="写真"</p><br><br>
			</div>
		</details>
			
			
		<details class="details">
        	<summary class="details-summary">2.予定の確認</summary>
        	
        	<div class="details-content">
			
				<p>ホーム画面から確認ボタンを押し、予定を確認したい月を選びます。</p><br>
				<p><img src="img/05.png" width="300" height="200"  alt="写真"</p><br><br>
				
				<p>すると先ほど登録した予定が表示されます！</p><br>
				<p><img src="img/06.png" width="300" height="400"  alt="写真"</p><br><br>
				
				
				<p>member02を追加してみると以下のようになります。確認画面はメンバー全員のスケジュールを確認することができ、メンバー全員が集まれる日時を「みんなが共通して空いてる時間」に表示しています！</p><br>
				<p>これで誰かがみんなの予定を見比べる必要がなくなりましたね！</p><br>
				<p><img src="img/07.png" width="300" height="400"  alt="写真"</p><br><br>
			</div>
		</details>
			
		
		<details class="details">
        	<summary class="details-summary">3.予定の追加・変更</summary>
        	
        	<div class="details-content">
			
				<p>予定を変更したいときは、変更したい日にち（期間）を選択して,
				</p><br>
				<p><img src="img/08.png" width="300" height="200"  alt="写真"</p><br><br>
				
				<p>予定を登録します。</p>
				<p><img src="img/09.png" width="300" height="150"  alt="写真"</p><br><br>
				
				<p>するとその日にち（期間）だけが上書きされます！他の日は変更されません！</p><br>
				<p><img src="img/10.png" width="300" height="150"  alt="写真"</p><br><br>
			
			</div>
		</details>
			
		
		<details class="details">
        	<summary class="details-summary">4.他バンドで登録した予定を持ってくる</summary>
        	
        	<div class="details-content">
			
				<p>複数バンドを掛け持ちしている場合、一つのバンドで入力した予定をそのまま他のバンドでも使いたいですよね。それを実現する機能あります！</p>
				<p>例として、ミセスとRADWINPSを掛け持ちしている「member_rad」さんが、RADWINPSに追加した一月の予定を、ミセスにも登録してみます！</p>
				
				<p>「member_rad」さんがRADWINPSに追加した予定は以下の通りです。これをミセスにも登録します。</p>
				<p><img src="img/11.png" width="300" height="250"  alt="写真"</p><br><br>
				
				<p>ホーム画面から登録ボタンを押し、入力する期間を選ぶ画面で、一番下の「他バンドで入力した予定をそのまま登録したい人はこちら」をクリック</p>
				<p><img src="img/12.png" width="300" height="250"  alt="写真"</p><br><br>
				
				<p>コピー元の情報を入力します。バンドIDは「rad」で、名前は「member_rad」で、１月の予定をコピーします。</p>
				<p><img src="img/13.png" width="300" height="200"  alt="写真"</p><br><br>
				
				<p>次へを押すとホーム画面に戻り、「コピーされました」というメッセージが表示されます。</p>
				<p><img src="img/14.png" width="300" height="280"  alt="写真"</p><br><br>
				
				<p>確認してみると.....コピーされていますね！</p>
				<p><img src="img/15.png" width="300" height="330"  alt="写真"</p><br><br>
				
			</div>
		</details>
			
		
		
		
		
		
		</div>
	</div>
	
	
	
	
</body>
</html>