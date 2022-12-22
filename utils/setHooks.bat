if exist ..\.git\hooks_orig (
    echo "hooks_orig exists"
) else (
    echo "backup hooks"
    move ..\.git\hooks ..\.git\hooks_orig
)

rmdir ..\.git\hooks
xcopy /s /e /y .\hooks ..\.git\hooks\
