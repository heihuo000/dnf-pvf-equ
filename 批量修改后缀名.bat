@echo off
setlocal enabledelayedexpansion

:loop
    echo 1. ��ԭ�к�׺�������.txt
    echo 2. ɾ���ļ��ĺ�׺��
    echo 3. �ϲ�����.txt �ļ�
    echo 4. �˳�
    set /p choice=��ѡ�����(1-4):
    if "!choice!"=="1" goto add_txt_suffix
    if "!choice!"=="2" goto remove_extension
    if "!choice!"=="3" goto merge_txt_files
    if "!choice!"=="4" goto end
    echo ��Ч��ѡ�����������룡
    pause
    goto loop

:add_txt_suffix
    echo 1. ����ǰĿ¼
    echo 2. ����������Ŀ¼
    set /p option=��ѡ�������Χ(1-2):
    if "!option!"=="1" goto add_txt_suffix_current
    if "!option!"=="2" goto add_txt_suffix_recursive
    echo ��Ч��ѡ�����������룡
    pause
    goto add_txt_suffix

:add_txt_suffix_recursive
    echo ���ڵݹ��Ϊ�����ļ����ų�.bat ��.doc����ԭ�к�׺�������.txt...
    for /r %%f in (*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            ren "%%f" "%%~nf%%~xf.txt"
        )
    )
    echo ��������ɣ�
    pause
    goto loop

:add_txt_suffix_current
    echo ����Ϊ��ǰĿ¼�������ļ����ų�.bat ��.doc����ԭ�к�׺�������.txt...
    for %%f in (*.*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            ren "%%f" "%%~nf%%~xf.txt"
        )
    )
    echo ��������ɣ�
    pause
    goto loop

:remove_extension
    echo 1. ����ǰĿ¼
    echo 2. ����������Ŀ¼
    set /p option=��ѡ�������Χ(1-2):
    if "!option!"=="1" goto remove_extension_current
    if "!option!"=="2" goto remove_extension_recursive
    echo ��Ч��ѡ�����������룡
    pause
    goto remove_extension

:remove_extension_recursive
    echo ���ڵݹ��ɾ����.bat �ͷ�.doc �ļ��ĺ�׺��...
    for /r %%f in (*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            set "filename=%%~nf"
            ren "%%f" "!filename!"
        )
    )
    echo ��������ɣ�
    pause
    goto loop

:remove_extension_current
    echo ����ɾ����ǰĿ¼�·�.bat �ͷ�.doc �ļ��ĺ�׺��...
    for %%f in (*.*) do (
        if /i "%%~xf" neq ".bat" if /i "%%~xf" neq ".doc" (
            set "filename=%%~nf"
            ren "%%f" "!filename!"
        )
    )
    echo ��������ɣ�
    pause
    goto loop

:merge_txt_files
    echo 1. ���ϲ���ǰĿ¼�µ�.txt �ļ�
    echo 2. �ϲ���ǰĿ¼����Ŀ¼�µ�.txt �ļ�
    set /p merge_option=��ѡ��ϲ���Χ(1-2):
    if "!merge_option!"=="1" goto merge_current_directory
    if "!merge_option!"=="2" goto merge_subdirectories
    echo ��Ч��ѡ�����������룡
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
    echo ��ǰĿ¼�ϲ���ɣ����ɵ��ļ�Ϊ��!output_file!
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
    echo �ϲ���ɣ����ɵ��ļ�Ϊ��!output_file!
    pause
    goto loop

:end
endlocal