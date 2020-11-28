# 確認
Write-Host "sudo"$Args[0]

# ダブルクォーテーションで始まっているとき
if ( $Args[0].StartsWith("`"") ) { 

    # 一つ目のダブルクォーテーションと二つ目のダブルクォーテーションの間がファイル名
    $s = $Args[0].Split("`"") 
    $filename = $s[1]

    # 「"ファイル名"」直後に1文字以上あったら = 引数があったら
    if ( $s[2].Length -gt 0) {
        $arguments = $Args[0].Substring($filename.Length + 3, $Args[0].Length - $filename.Length - 3)
    }
  
    # 絶対パスに展開（管理者シェルは C:\WINDOWS\system32で開かれるため）
    $path = "`"" + (Resolve-Path $filename).Path + "`""

    Write-Host "ファイル名`t$filename" 
    Write-Host "フルパス`t$path"
    Write-Host "オプション`t$arguments "

    # コマンドラインオプションを生成
    $argument_list = "-ExecutionPolicy Unrestricted -File " + $path + " " + $arguments

}
# ダブルクォーテーションで始まってないとき
else {

    # スペースより手前がファイル名かコマンド
    $s = $Args[0].Split(" ")
    $filename = $s[0]

    # スペースで区切ったとき２つ以上に分割されたら = 引数があったら
    if ( $s.Length -gt 1) {
        $arguments = $Args[0].Substring($filename.Length + 1, $Args[0].Length - $filename.Length - 1)
    } else {
        $arguments = ""
    }

    # ファイル名なら
    if ( Test-Path $filename ) {
  
        # 絶対パスに展開（管理者シェルは C:\WINDOWS\system32で開かれるため）
        $path = "`"" + (Resolve-Path $filename).Path + "`""

        Write-Host "ファイル名`t$filename"
        Write-Host "フルパス`t$path"
        Write-Host "オプション`t$arguments "

        # コマンドラインオプションを生成
        $argument_list = "-ExecutionPolicy Unrestricted -File " + $path + " " + $arguments
  
    }
    # コマンドなら
    else {

        Write-Host "コマンド`t$filename"
        Write-Host "オプション`t$arguments "

        # コマンドラインオプションを生成
        #「"」 を 「\」 でエスケープ
        $argument_list = "-Command " + $filename + " " + $arguments.replace("`"", "\`"")

    }
}

# 管理者シェルを起動する
Start-Process pwsh -ArgumentList $argument_list -Verb runas -Wait
