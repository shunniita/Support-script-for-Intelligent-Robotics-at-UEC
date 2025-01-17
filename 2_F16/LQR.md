# LQR制御


> 悪い やっぱ辛えわ


**目次**

- [LQR制御](#lqr制御)
- [いやーキツいっす](#いやーキツいっす)
- [LQR制御 とは](#lqr制御-とは)
    - [1. LQR制御の目的](#1-lqr制御の目的)
    - [2. LQR制御の数式](#2-lqr制御の数式)
    - [3. LQRの利点](#3-lqrの利点)
    - [4. LQRの応用](#4-lqrの応用)
- [で、どうすればいいのさ](#でどうすればいいのさ)



# いやーキツいっす
とりあえずPPGのときと同じようにやればいけるかな…と思って手を出してみたのであればおそらくこう思ったはずです。

**何なのだ、これは！どうすればいいのだ？！** …と。

今までやっていたPゲインとDゲインの制御のあれこれは全く役に立ちそうにありません…。これでどうやって戦えばいいんだ？

しかし諦めてはいけません。授業資料をよく読むと、「LQR制御」なる用語が書いてあります。どうやらこいつに手を出す必要がありそうです。

# LQR制御 とは
今度はChatGPT君に質問してみましょう。

---

ここからChatGPTの出力(一部抜粋)

---

LQR（線形二次レギュレータ）制御は、制御理論の一手法で、システムの状態を最適に制御するために用いられます。LQRは、特に制御対象が線形である場合に有効で、以下のような特性があります：

### 1. LQR制御の目的
LQR制御は、システムの状態 $x(t)$ をある目標状態にできるだけ早く、かつエネルギー消費を最小にしつつ移動させるために設計されています。LQRの「二次」という言葉は、以下の評価関数が2次形式であることに由来します：

$$J = \int _ 0^{\infty} (x(t)^T Q x(t) + u(t)^T R u(t)) \, dt$$

ここで、
- $x(t)$ はシステムの状態ベクトル、
- $u(t)$ は制御入力ベクトル、
- $Q$ は状態に関する重み行列、
- $R$ は制御入力に関する重み行列です。

評価関数 $J$ を最小化することによって、状態と制御入力のバランスを取ることが可能です。例えば、状態偏差（目標からのズレ）を小さくしたい場合は $Q$ の値を大きくし、制御入力のエネルギーを抑えたい場合は $R$ の値を大きくします。

### 2. LQR制御の数式
LQR制御では、次のような線形システムの状態空間モデルを仮定します：

$$\dot{x}(t) = A x(t) + B u(t)$$

ここで $A$ はシステム行列、$`B`$ は制御入力行列です。LQR制御則は、以下のようなフィードバック制御で表されます：

$$u(t) = -K x(t)$$

このとき、ゲイン行列 $K$ は次のリカッチ方程式を解くことで求められます：

$$A^T P + P A - P B R^{-1} B^T P + Q = 0$$

このリカッチ方程式の解 $P$ に基づいて、ゲイン行列 $K$ は以下のように計算されます：

$$K = R^{-1} B^T P$$

### 3. LQRの利点
- **エネルギー最小化**：評価関数 $J$ の最小化により、無駄なエネルギーを使わない効率的な制御が実現できます。
- **安定性**：適切な $Q$ と $R$ を選ぶことで、システムの安定性を保証することが可能です。
- **調整の柔軟性**：重み行列 $Q$ と $R$ の選択によって、状態の追従性能やエネルギー消費のトレードオフを調整することができます。

### 4. LQRの応用
LQR制御は、ロボットアームや無人航空機（ドローン）、車両の自動運転、経済モデル、発電所の管理システムなど、さまざまな分野で使用されています。線形二次制御が適用できる場面では、シンプルでありながら強力な制御手法となっています。

LQRは、対象が非線形である場合や、外乱が大きい環境でも拡張が可能で、例えば、拡張カルマンフィルタや線形二次ガウス制御（LQG）など、LQRを応用した手法も存在します。

---

ここまで

---

さて、授業資料をもう一度よく読んでみると、なんとここで言うところの行列$`A,B`$が配布資料として与えられているではありませんか！

ついでに言うと、MATLABではこの[LQR制御のための関数](https://jp.mathworks.com/help/control/ref/lti.lqr.html)が用意されています。

LQR関数の練習用に、`state_read.m`を用意してあります。実行してみましょう。

(ただし、MATLABをインストールしたときに必要最小限ものだけ入れていると「入ってないやん！」とエラーが出ることがあります。そういうときはMATLABのインストーラーをもう一回起動するなりして必要なやつをインストールしてください。)


# で、どうすればいいのさ

再びChatGPT君に聞いてみましょう。

---

ここからChatGPTの出力(一部抜粋)

> (ここで、このような引用形式での文字列は自分の入力を表します。)

---


> 少し話が変わりますが、次の数式について教えて下さい
> 
> ```latex
> u = 
> \begin{bmatrix}
> \delta_{th} - \delta_{th_0} \\
> \delta_e - \delta_{e_0}
> \end{bmatrix}
> =
> -
> \begin{bmatrix}
> f_{11} & f_{12} & f_{13} & f_{14} & f_{15} \\
> f_{21} & f_{22} & f_{23} & f_{24} & f_{25}
> \end{bmatrix}
> \begin{bmatrix}
> V - V_{ref} \\
> \alpha - \alpha_{ref} \\
> \dot{\theta} - \dot{\theta}_{ref} \\
> \theta - \theta_{ref} \\
> z - z_{ref}
> \end{bmatrix}
> ```

---

この数式は、制御理論や航空力学に関連する問題でよく見られるもので、**多入力多出力（MIMO）システム**の制御入力を表しています。特に航空機の姿勢制御や飛行制御の文脈で、スロットルと昇降舵の調整を行う制御系を表している可能性があります。

以下に、この式の各要素について解説します。

---

### **1. 数式全体の意味**
この式は、制御入力$`u`$を制御対象の状態変数と基準値の偏差（差分）に基づいてフィードバックで計算する形式です。

$$
u =
\begin{bmatrix}
\delta _ {th} - \delta _ {th _ 0} \\
\delta _ e - \delta _ {e _ 0}
\end{bmatrix}
= - \begin{bmatrix}
f _ {11} & f _ {12} & f _ {13} & f _ {14} & f _ {15} \\
f _ {21} & f _ {22} & f _ {23} & f _ {24} & f _ {25}
\end{bmatrix}
\begin{bmatrix}
V - V _ {ref} \\
\alpha - \alpha _ {ref} \\
\dot{\theta} - \dot{\theta} _ {ref} \\
\theta - \theta _ {ref} \\
z - z _ {ref}
\end{bmatrix}
$$

#### **左辺$`u`$：制御入力**
- $\delta _ {th}$：スロットル（推力）設定
- $\delta _ e$：昇降舵（ピッチ制御）設定
- $\delta _ {th _ 0} , \delta _ {e _ 0}$：それぞれの基準値（例えば、巡航時の設定値）

$u$は、スロットルと昇降舵の補正量を表します。

#### **右辺：フィードバック制御則**
##### 状態偏差：

$$
\begin{bmatrix}
V - V _ {ref} \\
\alpha - \alpha _ {ref} \\
\dot{\theta} - \dot{\theta} _ {ref} \\
\theta - \theta _ {ref} \\
z - z _ {ref}
\end{bmatrix}
$$

各成分は、制御対象の状態と基準値（目標値）の差を表します。
- $V$：速度
- $\alpha$：迎角（攻撃角）
- $\dot{\theta}$：ピッチ角速度
- $\theta$：ピッチ角
- $z$：高度

##### ゲイン行列（フィードバック行列）：

$$
\begin{bmatrix}
f _ {11} & f _ {12} & f _ {13} & f _ {14} & f _ {15} \\
f _ {21} & f _ {22} & f _ {23} & f _ {24} & f _ {25}
\end{bmatrix}
$$

各成分 $f _ {ij}$ は、制御入力と状態偏差の関係を定量化する係数です。この行列は、制御性能を最適化するために調整されます（例えば、LQRで計算されることがあります）。

---

### **2. 各要素の詳細**
#### **状態偏差**
- $V - V _ {ref}$：速度の偏差（実際の速度と目標速度の差）
- $\alpha - \alpha _ {ref}$：迎角の偏差（目標迎角とのズレ）
- $\dot{\theta} - \dot{\theta} _ {ref}$：ピッチ角速度の偏差
- $\theta - \theta _ {ref}$：ピッチ角の偏差（目標姿勢との差）
- $z - z _ {ref}$：高度の偏差（目標高度との差）

#### **フィードバック行列**
この行列は、各状態偏差が制御入力（スロットル、昇降舵）にどの程度影響するかを決めます。具体的には：
- 行の数：制御入力の数（ここでは2つ：スロットル、昇降舵）
- 列の数：状態偏差の数（ここでは5つ）

たとえば：
- $f _ {11}$：速度偏差がスロットルに与える影響
- $f _ {25}$：高度偏差が昇降舵に与える影響

---

### **3. 制御の流れ**
この式は、次のようなフィードバック制御の流れを示しています：

1. **状態観測**：センサー等で現在の状態（速度、迎角、ピッチ角など）を取得。
2. **偏差計算**：現在の状態と基準値（目標値）の差を計算。
3. **制御入力計算**：偏差をゲイン行列で重み付けしてスロットルと昇降舵の補正量を計算。
4. **制御出力**：スロットルと昇降舵を調整して制御対象を目標状態に近づける。

---

### **4. 応用例**
このような式は、航空機やドローンの飛行制御において一般的です。例えば：
- スロットルを調整して速度や高度を制御。
- 昇降舵を操作して迎角やピッチ角を調整。

---

### **5. MATLABでの実装例**
MATLABでこの制御を実装する場合、次のように行えます：

```matlab
% 状態偏差
delta_x = [V - V_ref; alpha - alpha_ref; theta_dot - theta_dot_ref; theta - theta_ref; z - z_ref];

% フィードバック行列
F = [
    f11, f12, f13, f14, f15;
    f21, f22, f23, f24, f25
];

% 制御入力計算
u = -F * delta_x;

% 結果の表示
disp('Control Input:');
disp(u);
```

このようにして、偏差とフィードバック行列を用いて制御入力を計算できます。

---

> 初歩的な質問ですが、状態ベクトルには目標値と現在の値の差を取っても良いのでしょうか？

---

はい、**状態ベクトルに目標値と現在値の差（偏差）を取ることは一般的に有効**で、むしろ多くの制御系設計で積極的に使用されます。以下に、その理由と注意点を詳しく解説します。

---

### **1. 状態ベクトルに偏差を使う理由**
目標値と現在値の差を状態ベクトルに用いる理由は次の通りです：

#### **(1) 目標追従制御に適している**
制御系の目的が「目標値（基準値）を追従すること」である場合、現在値が目標値に近いかどうかを直接表現できる偏差は重要です。状態ベクトルを偏差で表すことで、制御入力を目標追従に適した形で設計できます。

#### **(2) LQR制御の評価関数との整合性**
LQR制御の目的は、次の評価関数を最小化するフィードバックゲイン $K$ を求めることです：

$$
J = \int _ {0}^{\infty} \left( x^T Q x + u^T R u \right) dt
$$

ここで $x$ が偏差ベクトルであれば、評価関数 $J$ は目標値との差を最小化するために最適化されます。その結果、目標値に対して効率的に制御を行うことが可能です。

#### **(3) システムの安定化と目標値への収束**
偏差を用いることで、現在値が目標値にどの程度近づいているかが明確になり、設計したフィードバックゲインがシステムを安定化しつつ、目標値に収束させることが可能になります。

---

### **2. 状態ベクトルに偏差を使う場合の注意点**

#### **(1) システムモデルが目標値を中心に記述されている必要がある**
状態ベクトルが偏差で表されている場合、システムのモデル（すなわち、状態空間モデル）も偏差に基づいて構築されている必要があります。具体的には、次のように変換します：

1. 元の状態空間モデル：
   $\dot{x} = A x + B u$
2. 偏差を考慮した状態空間モデル：
   $\dot{\tilde{x}} = A \tilde{x} + B \tilde{u}$

ここで：
- $\tilde{x} = x - x _ {ref}$：状態偏差
- $\tilde{u} = u - u _ {ref}$：制御入力偏差

#### **(2) 目標値が変化する場合**
目標値（基準値）が固定されていれば問題ありませんが、時間とともに変化する場合は、目標値の変化率 $\dot{x} _ {ref}$ を考慮した補正が必要になります。具体的には：

$$
\dot{\tilde{x}} = A \tilde{x} + B \tilde{u} + \dot{x} _ {ref}
$$

このような項が加わると制御系の設計が少し複雑になりますが、適切な設計手法（例えばゲインスケジューリングや補償器設計）を使うことで対応可能です。

---

### **3. 目標値との差を取らない場合との比較**
#### **(1) 差を取る場合（偏差系の設計）**
- システムの目標値への収束性が明確。
- 制御の目的が「目標値追従」なら自然な方法。
- 評価関数（例えば $x^T Q x$）が物理的意味を持ちやすい。

#### **(2) 差を取らない場合（絶対値系の設計）**
- 目標値を直接考慮しない場合や、特定の基準点（例：原点）での安定化のみが目的の場合に適する。
- 目標値を外部から別途補正して制御に組み込む必要がある。
- LQR制御を用いる場合、目標値との差を考慮しないと望む動作を得にくい。

---

### **4. まとめ**
状態ベクトルに目標値との差を取ることは、以下の点で特に有効です：
- 目標追従制御を設計する場合。
- LQR制御の評価関数と整合性を持たせたい場合。

ただし、システムモデルが偏差に基づいて記述されているかどうかを確認する必要があります。実際のシステムで目標値を変化させる場合は、その変化を制御系設計に反映させることを忘れないようにしましょう。

---

> なるほど、ありがとうございます。
> 
> では話を戻して、行列QとRを調整することでより良い制御にしていきたいのですが、どのように調整すれば良いでしょうか？

---

行列 $Q$ と $R$ の調整は、LQR制御の**性能**や**バランス**に大きく影響を与えます。それぞれの役割と調整方法を具体的に説明します。

---

### **1. $Q$ と $R$ の役割**
- **$Q$：状態偏差のペナルティ（重み付け）**
  - 状態偏差 $x$ のどの要素を重要視するかを決めます。
  - $Q$ の対角成分を大きくすると、その対応する状態偏差をより小さくしようと制御が働きます。
  - 非対角成分を設定することで、状態間の相互作用を考慮できますが、基本的には対角行列として調整するのが一般的です。

- **$R$：制御入力のペナルティ（重み付け）**
  - 制御入力 $u$ のどの成分を抑えたいかを決めます。
  - $R$ の値を大きくすると、制御入力を過剰に使わないように抑制する効果があります。
  - $R$ の値が小さいと、積極的な制御（大きな制御入力）が許容されます。

---

### **2. 調整の基本方針**

#### **(1) $Q$ の調整**
- **重要な状態変数に高い重みを付ける**
  - 例：高度の偏差 $z - z _ {ref}$ を小さくしたい → 対応する $Q$ の対角成分を増やす。
  - 速度偏差 $V - V _ {ref}$ を厳密に追従させたい → 対応する $Q$ の対角成分を増やす。

- **大きすぎる値に注意**
  - $Q$ を極端に大きくすると、システムが不安定になる場合があります。

- **状態間の優先順位を決める**
  - 各成分の物理的な単位（例：速度 vs 角度）が異なる場合は、適切にスケーリングします。

---

#### **(2) $R$ の調整**
- **制御コストを抑える**
  - $R$ の値を大きくすると、制御入力を少なく抑えるように働きます。
  - 例えば、スロットルや舵角の変化をできるだけ少なくしたい場合に有効です。

- **応答速度を考慮**
  - $R$ を小さくすると、システムは素早く応答しますが、制御入力が激しくなる可能性があります。

- **入力間のバランスを取る**
  - スロットル $\delta _ {th}$ と舵角 $\delta _ e$ の重要度が異なる場合は、非対角行列または異なるスケールの対角成分を設定します。

---

### **3. 実際の調整手順**

#### **(1) 初期設定**
- $Q$ を対角行列として設定：
  $Q = \text{diag}(q _ 1, q _ 2, \dots, q _ n)$
  初期値として、各成分を1または適当な値に設定します。

- $R$ をスカラーまたは小さな対角行列として設定：
  $R = \text{diag}(r _ 1, r _ 2, \dots, r _ m)$
  初期値として、各成分を1または適当な値に設定します。

---

#### **(2) 試行と調整**
1. **シミュレーションで挙動を確認**
   - 初期設定でシステム応答（状態変数の時間応答、制御入力の大きさ）を確認します。

2. **目標状態への収束速度を調整**
   - $Q$ の重みを増やす：
     - 状態偏差が目標値に速く収束する。
     - 制御入力が大きくなる傾向がある。

   - $R$ の重みを増やす：
     - 制御入力が滑らかになる（制御入力の変動が少なくなる）。
     - 状態偏差の収束速度が遅くなる可能性がある。

3. **過渡応答（オーバーシュートや振動）の抑制**
   - $Q$ の値を微調整し、特定の状態変数の応答を抑える。
   - $R$ を増やして制御入力を抑えることで、過剰な制御による振動を防ぐ。

4. **物理的な制約を考慮**
   - スロットルや舵角に物理的な限界がある場合、これを考慮して $R$ を増加させる。

---

### **4. MATLABでの実装例**
MATLABでは、`lqr` 関数を使って $Q$ と $R$ を調整しながらシミュレーションするのが一般的です。

```matlab
% システム行列
A = [...]; % システムダイナミクス
B = [...]; % 入力行列

% 初期のQとR
Q = diag([10, 10, 1, 1, 1]); % 状態変数ごとの重み
R = diag([1, 1]);            % 制御入力の重み

% LQRゲイン計算
K = lqr(A, B, Q, R);

% システムの閉ループ応答
sys_cl = ss(A - B*K, [], [], []);

% シミュレーション
t = 0:0.01:10; % 時間ベクトル
initial_state = [0.1; 0.1; 0; 0; 0]; % 初期偏差
[y, t, x] = initial(sys_cl, initial_state, t);

% 結果プロット
figure;
plot(t, x);
xlabel('Time (s)');
ylabel('State variables');
legend('V - V_{ref}', '\alpha - \alpha_{ref}', '\dot{\theta} - \dot{\theta}_{ref}', '\theta - \theta_{ref}', 'z - z_{ref}');
title('State response under LQR control');
```

---

### **5. 調整のヒント**
- **$Q$ を優先して調整する**：
  - 状態応答が目標値に収束するかどうかをまず確認します。

- **$R$ を後から調整**：
  - 制御入力が大きすぎる場合に、徐々に $R$ を大きくします。

- **シミュレーションと実機の乖離に注意**：
  - 実際のシステムでは、モデル誤差や非線形性を考慮する必要があります。シミュレーション結果が現実に合わない場合、余裕を持たせて $R$ を少し大きくすることがあります。

---

### **6. まとめ**
- **$Q$ の対角成分を調整**：目標値への収束性を重視。
- **$R$ の対角成分を調整**：制御入力の滑らかさを重視。
- **シミュレーションを繰り返す**ことで、必要な応答特性に合わせて調整します。

制御の目的（応答速度 vs 制御コスト）を常に意識しながら、試行錯誤することが重要です！


---

ここまで

---

# 実際にやってみよう
まぁここまで読んだのであれば`parameter.m`や`auto_simu_gain.ps1`の改変方法は理解できているでしょう。サンプルコードも用意してありますし。

さて、実際にLQR制御で得たゲインをシミュレーションで試してみましょう。とりあえず$`Q,R`$の対角成分を全部$`1.0`$にして…すると、おそらく失敗すると思います。

なんでや！と思うでしょうが、実際にウインドウを表示して見ると、いきなり全力で上昇しようとしていることがわかります。セオリー通りに行くならまずは$`Q`$からなのですが、これは$`R`$の方から調整するべきでしょう。とりあえずクソデカ値をいくつか試してみると、おそらくどこかでうまくいく数値が見つかるはずです(デカスギだと目標地点にたどり着けなくなるので、そうなったら減らしましょう)。

あとはあらゆる条件でうまくいくパラメータを見つけるだけです！ある条件でうまく行ったとしても、ちょっと条件を変えるだけでうまくいかなくなる…なんてことはザラにあるので、まぁ頑張ってみてください。

ちなみに自分は全部に対応できるところまでは到達できませんでした…。現時点で全体の順位はわかりませんが、脱落者もそこそこいるとすればそんなに悪い結果にはならないと思います。たぶん。

これを読んだあなたは、きっともっとうまくやってくれるでしょう…。

# 追記
時が経ち、結果が公表されたのでここに自分の記録を残しておきます。

なお、全体の順位的にはほぼ半分(厳密には半分からすぐ下くらい)でした。下から1/4くらいがテストケース全落ちだったことを踏まえると、2ケース通過はほぼ素人にしてはようやったと言えるのでは…？

というわけで、こちらも参考までに2024年度の自分の結果とスコアを置いておきます。


## 個別

| ケース | 競技結果 | 時間(0→1)   | 時間(1→2)   | 時間(合計)  | 時間の順位 | 時間の点数 | スロットル入力(0→1) | エレベータ入力(0→1) | 総入力量(0→1) | スロットル入力(1→2) | エレベータ入力(1→2) | 総入力量(1→2) | スロットル入力(合計) | エレベータ入力(合計) | 総入力量(合計) | 総入力量の順位 | 総入力量の点数 | スコア |
| ------ | -------- | ----------- | ----------- | ----------- | ---------- | ---------- | ------------------- | ------------------- | ------------- | ------------------- | ------------------- | ------------- | -------------------- | -------------------- | -------------- | -------------- | -------------- | ------ |
| 1      | 失格     | 232.5536915 |             |             |            | 0.5        | 585.4545206         | 103.5748904         | 689.029411    |                     |                     |               |                      |                      |                |                | 0.5            | 1      |
| 2      | 成功     | 232.5536915 | 234.5122088 | 467.0659003 | 28         | 2.3        | 585.4545206         | 103.5748904         | 689.029411    | 652.3631175         | 168.636107          | 820.9992245   | 1237.81764           | 272.2109974          | 1510.029       | 23             | 2.8            | 5.1    |
| 3      | 成功     | 198.7707592 | 182.5797474 | 381.3505    | 50         | 0.5        | 220.3910782         | 90.70926634         | 311.1003445   | 130.9948804         | 66.50920908         | 197.5040895   | 351.385959           | 157.218475           | 508.6044339    | 9              | 4.2            | 4.7    |
| 4      | 失格     |             |             |             |            | 0.5        |                     |                     |               |                     |                     |               |                      |                      |                |                | 0.5            | 1      |
| 5      | 失格     |             |             |             |            | 0.5        |                     |                     |               |                     |                     |               |                      |                      |                |                | 0.5            | 1      |

## 全体

|          |      |
| -------- | ---- |
| ケース1  | 1    |
| ケース2  | 5.1  |
| ケース3  | 4.7  |
| ケース4  | 1    |
| ケース5  | 1    |
| 平均     | 2.56 |
| 最終成績 | 2.69 |
