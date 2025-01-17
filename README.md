# Support-script-for-Intelligent-Robotics-at-UEC

# これはなに？
電気通信大学の授業である知能ロボット工学の課題をちょっと楽にするPowerShellスクリプトです。

なお、Windowsユーザーを対象として説明します。macOSやLinuxなどを使用している人はきっと十分な技術力があると思うので`0_practice`の説明も参考にしつつ自力でシェルスクリプトを書いてみてください。

~~Pull Requestされたらもしかしたら対応するかも？~~

# 具体的には何をするの？
課題というのはざっくり言うとMATLAB上で航空機を制御するシミュレーションを行うというもので…シミュレーションがうまくいくように、そして効率よく行えるように制御用のパラメータの数値を調整するのですが、このパラメータ調整がなかなかに面倒で、初見だとどういう方針で探せばいいのか、そもそも値の最大値&最小値はどれくらいなのかもわからないまま、提出期限を迎えてしまい結局適当な数値を提出点のためだけに出すことになってしまいます。

というわけで人力で探索するのが面倒ならば、プログラムを書いてコンピュータにやらせてしまおうというわけです。具体的には、ランダムな値を何回も試しまくってうまくいく値が見つかったらその周辺に範囲を絞ってまた何回も試す…という、単純な戦法です。シンプル・イズ・ベスト。

競技プログラミングのヒューリスティックコンテストで使われるような手法の方がより効率よく値を見つけられるとは思いますが、自分の技術力不足のために「下手な鉄砲も数打ちゃ当たる」戦略しか取れませんでした…。これを実装するのは読者の演習問題とします。

# つかいかた
## Git？なにそれ？な人向け
1. このGitHubのページの右上あたりに、「Code」と書かれている緑色のボタンがあるはずなので、そこをクリックします。
2. クリックすると出現するメニューの下の方に「Download ZIP」というところがあるので、そこをクリックします。
3. するとスクリプトとかが全部入ったzipファイルがダウンロードされるので、適当なところで展開してください。
4. これ以降は各フォルダ内の`README.md`に従ってください。念の為書いておくと拡張子が`.md`のファイルは普通にメモ帳で開けます。

## Gitが必要最小限以上は使える人向け
上記のようにzipでダウンロードするのが楽だとは思いますが、cloneなりforkしてもいいと思います。

コードとかに改善点があったら教えてくれると助かります。

# フォルダの説明
## 0_practice
どういう方式でMATLABに入力を渡すのか、そして出力を記録するのか…の解説および入出力の練習用です。

## 1_PPG
Powered ParaGlider(PPG)の3D空間上での飛行シミュレーション用です。比較的シンプルな手法でそこそこ良い結果が出ます。

## 2_F16
F16のシミュレーション用ですが、簡単のため真横から見た2Dでの制御となっています。しかしながら、それでもなおシビアな調整が求められます。

~~そもそも現代の戦闘機は安定性を捨てて運動性能に全振りしており、もちろんそれだとまともに操縦できないのでコンピュータによって無理やり安定させています。つまり初見の学生に3Dでの制御なんかさせられるわけがないのです。だから2Dにして、しかも状況を限定して近似させる必要があったんですね。~~

PPGでも用いたシンプルな手法でも技術的には可能です……たぶん。それだと不満な人向けに応用的な手法についても説明してあります。
