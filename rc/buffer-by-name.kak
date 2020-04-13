declare-option -hidden str buffer_by_name_path %sh(
    printf "%s" "${kak_source%.kak}"
)

provide-module buffer-by-name %~

define-command buffer-by-name \
    -params 1 \
    -docstring "buffer-by-name <name>: open a buffer by name.
This is different from :buffer in that :buffer expects a path." \
    -shell-script-candidates %(
        PATH="$kak_opt_buffer_by_name_path:$PATH"
        eval set -- $kak_quoted_buflist
        printf '%s\n' "$@" | candidates --filter
    ) \
%(
    buffer %sh(
        PATH="$kak_opt_buffer_by_name_path:$PATH"
        filtered_file="$1"
        eval set -- $kak_quoted_buflist
        printf '%s\n' "$@" | candidates --invert "$filtered_file"
    )
)

~
