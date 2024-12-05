# 出力用の区切り線
$separator = "###############################################################"

# スクリプトブロック
# Matlabのmain.mを実行し、結果を$resultFileに保存する
$scriptBlock = {
    matlab -batch "main" -logfile "temp.log"
}

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

# シミュレーション回数カウント用
$simu_count = 0


for ($thp = 1; $thp -le 100; $thp += 1) {
    # for ($dp = 0.01; $dp -le 1.0; $dp += 0.01) { # Dゲイン用


    # 1. パラメータを4つ設定
    $param1 = $thp
    $param2 = 0 # $dp
    $param3 = $thp
    $param4 = 0 # $dp

    # シミュレーション回数をカウント
    $simu_count++
    # 現在時刻を取得
    $nowTime = Get-Date

    # シミュレーション情報を表示
    Write-Host "$separator"
    Write-Host "シミュレーション [$simu_count]"
    Write-Host "現在時刻: $nowTime"
    Write-Host ""
    Write-Host "# パラメータ"
    Write-Host "Th_P = $param1"
    Write-Host "Th_D = $param2"
    Write-Host "delta_P = $param3"
    Write-Host "delta_D = $param4"
    Write-Host ""

    # シミュレーション情報を simu_result.txt に追記
    Add-Content -Path $resultFile -Value "$separator"
    Add-Content -Path $resultFile -Value "シミュレーション [$simu_count]"
    Add-Content -Path $resultFile -Value "現在時刻: $nowTime"
    Add-Content -Path $resultFile -Value ""
    Add-Content -Path $resultFile -Value "# パラメータ"
    Add-Content -Path $resultFile -Value "Th_P = $param1"
    Add-Content -Path $resultFile -Value "Th_D = $param2"
    Add-Content -Path $resultFile -Value "delta_P = $param3"
    Add-Content -Path $resultFile -Value "delta_D = $param4"
    Add-Content -Path $resultFile -Value ""

    # 2. 生成したパラメータを gain.dat に保存
    "$param1 $param2 $param3 $param4" | Out-File -FilePath "gain.dat" -Force

    # 3. matlab スクリプトを呼び出してシミュレーションを実行
    # 処理をジョブとして実行
    $job = Start-Job -ScriptBlock $scriptBlock

    try {
        # タイムアウト時間内にジョブが完了するか確認
        if (Wait-Job -Job $job -Timeout $timeout) {
            # ジョブが完了した場合、標準出力の最後の20行を取得
            $output = Receive-Job -Job $job | Select-Object -Last 20
            Write-Output "ジョブの最後の20行の出力:"
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


    # 4. シミュレーション結果を temp.log から取得し、垂直タブを削除して最後の20行を simu_result.txt に追記
    Add-Content -Path $resultFile -Value "# 結果"
    Get-Content "temp.log" | ForEach-Object { $_ -replace "`r|`n|`v|\u000B", "" } | Select-Object -Last 20 | ForEach-Object { Add-Content -Path $resultFile -Value $_ }
    Add-Content -Path $resultFile -Value ""
    # } # Dゲイン用
}

# 効果音
[Console]::Beep(440, 2000)
Write-Output "シミュレーションが完了しました。"
