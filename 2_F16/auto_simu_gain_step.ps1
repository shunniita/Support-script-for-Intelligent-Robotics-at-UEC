# 出力用の区切り線
$separator = "########################################"

# スクリプトブロック
# Matlabのmain.mを実行し、結果を$resultFileに保存する
$scriptBlock = {
    matlab -batch "main" -logfile "temp.log"
}

# シミュレーションを実行する回数
$numberOfSimulations = 50000

# シミュレーション結果を保存するファイル
$resultFile = "result/simu_result_202X1234.txt"

# タイムアウト時間(秒)
$timeout = 2 * 60

###############################################################

# シミュレーション実行
Write-Output "シミュレーションを開始します。"

Add-Content -Path $resultFile -Value ""

# シミュレーションの開始時刻を取得
$startTime = Get-Date

Write-Output "シミュレーション開始時刻: $startTime"
Add-Content -Path $resultFile -Value "シミュレーション開始時刻: $startTime"

for ($i = 1; $i -le $numberOfSimulations; $i++) {

    # 1. パラメータを10個生成
    $param01 = 0.7 + $i * 0.05
    $param02 = 0.7 + $i * 0.05
    $param03 = 0.7 + $i * 0.05
    $param04 = 0.7 + $i * 0.05
    $param05 = 0.7 + $i * 0.05
    $param06 = 0.7 + $i * 0.05
    $param07 = 0.7 + $i * 0.05
    $param08 = 0.7 + $i * 0.05
    $param09 = 0.7 + $i * 0.05
    $param10 = 0.7 + $i * 0.05

    # 現在時刻を取得
    $nowTime = Get-Date

    # シミュレーション情報を表示
    Write-Host "$separator"
    Write-Host "シミュレーション [$i]"
    Write-Host "現在時刻: $nowTime"
    Write-Host ""
    Write-Host "# 推力"
    Write-Host "f_11 = $param01"
    Write-Host "f_12 = $param02"
    Write-Host "f_13 = $param03"
    Write-Host "f_14 = $param04"
    Write-Host "f_15 = $param05"
    Write-Host ""
    Write-Host "# エレベータ"
    Write-Host "f_21 = $param06"
    Write-Host "f_22 = $param07"
    Write-Host "f_23 = $param08"
    Write-Host "f_24 = $param09"
    Write-Host "f_25 = $param10"
    Write-Host ""

    # シミュレーション情報を simu_result.txt に追記
    Add-Content -Path $resultFile -Value "$separator"
    Add-Content -Path $resultFile -Value "シミュレーション [$i]"
    Add-Content -Path $resultFile -Value "現在時刻: $nowTime"
    Add-Content -Path $resultFile -Value ""
    Add-Content -Path $resultFile -Value "# 推力"
    Add-Content -Path $resultFile -Value "f_11 = $param01"
    Add-Content -Path $resultFile -Value "f_12 = $param02"
    Add-Content -Path $resultFile -Value "f_13 = $param03"
    Add-Content -Path $resultFile -Value "f_14 = $param04"
    Add-Content -Path $resultFile -Value "f_15 = $param05"
    Add-Content -Path $resultFile -Value ""
    Add-Content -Path $resultFile -Value "# エレベータ"
    Add-Content -Path $resultFile -Value "f_21 = $param06"
    Add-Content -Path $resultFile -Value "f_22 = $param07"
    Add-Content -Path $resultFile -Value "f_23 = $param08"
    Add-Content -Path $resultFile -Value "f_24 = $param09"
    Add-Content -Path $resultFile -Value "f_25 = $param10"
    Add-Content -Path $resultFile -Value ""

    # 2. 生成したパラメータを保存
    "$param01 $param02 $param03 $param04 $param05" | Out-File -FilePath "thrust.dat" -Force
    "$param06 $param07 $param08 $param09 $param10" | Out-File -FilePath "elevator.dat" -Force

    # 3. matlab スクリプトを呼び出してシミュレーションを実行
    # 処理をジョブとして実行
    $job = Start-Job -ScriptBlock $scriptBlock

    try {
        # タイムアウト時間内にジョブが完了するか確認
        if (Wait-Job -Job $job -Timeout $timeout) {
            # ジョブが完了した場合、標準出力の最後の30行を取得
            $output = Receive-Job -Job $job | Select-Object -Last 30
            Write-Output "ジョブの最後の30行の出力:"
            Write-Output $output
        }
        else {
            # タイムアウトに達した場合
            Stop-Job -Job $job
            Write-Output "ジョブがタイムアウトしました。"
            Add-Content -Path $resultFile -Value "$timeout 秒経過 タイムアウト"
        }
    }
    finally {
        # エラーが発生してもジョブを確実に削除
        if ($job.State -ne 'Completed' -and $job.State -ne 'Failed') {
            Stop-Job -Job $job -ErrorAction SilentlyContinue
        }
        Remove-Job -Job $job -ErrorAction SilentlyContinue
        Write-Output "ジョブが削除されました。"
    }

    # 4. シミュレーション結果を temp.log から取得し、垂直タブを削除して最後の30行を simu_result.txt に追記
    Add-Content -Path $resultFile -Value "# 結果"
    Get-Content "temp.log" | ForEach-Object { $_ -replace "`r|`n|`v|\u000B", "" } | Select-Object -Last 30 | ForEach-Object { Add-Content -Path $resultFile -Value $_ }
    Add-Content -Path $resultFile -Value ""
}

# 効果音
[Console]::Beep(440, 2000)
Write-Output "シミュレーションが完了しました。"
