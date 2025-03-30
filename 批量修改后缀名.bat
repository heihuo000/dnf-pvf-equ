@echo off
setlocal enabledelayedexpansion

:loop
    echo 1. 在原有后缀名后添加.txt
    echo 2. 删除文件的后缀名
    echo 3. 合并所有.txt 文件
    echo 4. 退出
    set /p choice=请选择操作(1-4):
    if "!choice!"=="1" goto add_txt_suffix
    if "!choice!"=="2" goto remove_extension
    if "!choice!"=="3" goto merge_txt_files
    if "!choice!"=="4" goto end
    echo 无效的选择，请重新输入！
    pause
    goto loop

:add_txt_suffix
    echo 1. 仅当前目录
    echo 2. 包含所有子目录
    set /p option=请选择操作范围(1-2):
    if "!option!"=="1" goto add_txt_suffix_current
    if "!option!"=="2" goto add_txt_suffix_recursive
    echo 无效的选择，请重新输入！
    pause
    goto add_txt_suffix

:add_txt_suffix_recursive
    echo 正在递归地为所有文件（排除.bat 和.doc）在原有后缀名后添加.txt...
    for /r %%f in (*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            ren "%%f" "%%~nf%%~xf.txt"
        )
    )
    echo 操作已完成！
    pause
    goto loop

:add_txt_suffix_current
    echo 正在为当前目录下所有文件（排除.bat 和.doc）在原有后缀名后添加.txt...
    for %%f in (*.*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            ren "%%f" "%%~nf%%~xf.txt"
        )
    )
    echo 操作已完成！
    pause
    goto loop

:remove_extension
    echo 1. 仅当前目录
    echo 2. 包含所有子目录
    set /p option=请选择操作范围(1-2):
    if "!option!"=="1" goto remove_extension_current
    if "!option!"=="2" goto remove_extension_recursive
    echo 无效的选择，请重新输入！
    pause
    goto remove_extension

:remove_extension_recursive
    echo 正在递归地删除非.bat 和非.doc 文件的后缀名...
    for /r %%f in (*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            set "filename=%%~nf"
            ren "%%f" "!filename!"
        )
    )
    echo 操作已完成！
    pause
    goto loop

:remove_extension_current
    echo 正在删除当前目录下非.bat 和非.doc 文件的后缀名...
    for %%f in (*.*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            set "filename=%%~nf"
            ren "%%f" "!filename!"
        )
    )
    echo 操作已完成！
    pause
    goto loop

:merge_txt_files
    echo 1. 仅合并当前目录下的.txt 文件
    echo 2. 合并当前目录及子目录下的.txt 文件
    set /p merge_option=请选择合并范围(1-2):
    if "!merge_option!"=="1" goto merge_current_directory
    if "!merge_option!"=="2" goto merge_subdirectories
    echo 无效的选择，请重新输入！
    pause
    goto merge_txt_files

:merge_current_directory
    set "output_file=merged_files_in_current_directory.txt"
    del "%output_file%" 2>nul
    for %%f in (*.txt) do (
        if "%%f" neq "!output_file!" (
            echo [%%f] >> "!output_file!"
            type "%%f" >> "!output_file!"
            echo. >> "!output_file!"
            echo ------------------------- >> "!output_file!"
        )
    )
    echo 当前目录合并完成！生成的文件为：!output_file!
    pause
    goto loop

:merge_subdirectories
    set "output_file=merged_files_including_subdirectories.txt"
    del "%output_file%" 2>nul
    for /r %%f in (*.txt) do (
        if "%%f" neq "!output_file!" (
            echo [%%f] >> "!output_file!"
            type "%%f" >> "!output_file!"
            echo. >> "!output_file!"
            echo ------------------------- >> "!output_file!"
        )
    )
    echo 合并完成！生成的文件为：!output_file!
    pause
    goto loop

:end
endlocal