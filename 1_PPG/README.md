# PPG用のスクリプト

ここではPPG用のスクリプトの内容およびその使い方について説明します。

**目次**

- [PPG用のスクリプト](#ppg用のスクリプト)
- [各スクリプトについて](#各スクリプトについて)
- [スクリプトの内容について](#スクリプトの内容について)
  - [auto\_simu\_gain](#auto_simu_gain)
  - [auto\_simu\_gain\_step](#auto_simu_gain_step)
  - [test\_case\_generator](#test_case_generator)



# 各スクリプトについて

* auto_simu_gain.ps1: パラメータをランダムで生成してシミュレーションを行います。説明通りのやつです。
* auto_simu_gain_step.ps1: パラメータを少しずつ変化させながらシミュレーションを行います。計算量のオーダーに注意。
* test_case_generator.ps1: 初期条件等をランダムで生成します。見つかったパラメータの対応力を試したいときに。

# スクリプトの内容について
## auto_simu_gain

## auto_simu_gain_step
`auto_simu_gain`とほぼ変わりません。パラメータが乱数ではなくfor文のやつになっています。そこで上限や加減、刻み幅を指定してください。

コメントアウトを外せばDゲインも変化させられますが、シミュレーション回数が2乗で増えることに注意してください。

## test_case_generator
見ればだいたいわかるとは思います。ちなみに表示される文字列はそのままコピペできるようにMATLABの形式に合わせてあります。
