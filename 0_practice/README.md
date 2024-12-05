# 前提条件
課題のために配布されるファイルのほとんどは拡張子が`.p`となっており、編集不可能になっている。唯一改変可能なのが`parameter.m`であり、おそらく`main.p`の中の最初の方でこのファイルが読み込まれていると推測できる。

そしてどうやら読み込まれる際に**上から一行ずつ実行されている**みたいなのだ。

ということは…指定されたパラメータだけちゃんと代入してさえあればその前の段階でどれだけ計算されていようが…いや、(途中で強制終了させるみたいな無茶以外なら)何をしても許されるのである。

# 基本方針
とはいえ、MATLABの動作はそこそこ重くなるので、MATLAB側でやることはできるだけ少なくしておきたい。

どのみち何回も実行する羽目になるのだ(そしてそれは`parameter.m`の改変だけでは不可能)。ランダムな値を生成するのは外側で行い、それをMATLABに渡すことにする。

さて、MATLAbはCLIで扱うこともできる。

[matlab (Windows)](https://jp.mathworks.com/help/matlab/ref/matlabwindows.html)

詳しくは上のURL先を参照してもらいたいのだが、要するに次のような形式でコマンドを入力すればいい。

```bash
$ matlab -batch "my_script"
```

となると標準入力を扱うことになりそうだ。まずは[input](https://jp.mathworks.com/help/matlab/ref/input.html)を使ってみよう。

```matlab
x = input('');

disp(x)
```

入力をそのまま表示するだけのプログラムだ。このファイルを`stdin_test.m`として保存し、`matlab -batch stdin_test`と入力してみると…

```
次を使用中のエラー: input
ユーザー入力のサポートが必要ですが、このプラットフォームでは使用できません。

エラー: stdin_test (行 1)
x = input('');
    ^^^^^^^^^

ERROR: MATLAB error Exit Status: 0x00000001
```

なんてこった。

---

仕方がないので他の方法を探そう。今度は外部のファイルを読み込む関数を探すと…[load](https://jp.mathworks.com/help/matlab/ref/load.html)という関数があった。


