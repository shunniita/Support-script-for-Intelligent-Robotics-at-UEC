# 基本方針
まず、MATLABの動作はそこそこ重くなるので、MATLAB側でやることはできるだけ少なくしておきたい。

というわけでランダムな値を生成するのは外側で行い、それをMATLABに渡すことにする。

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
