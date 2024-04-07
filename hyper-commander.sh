#! /usr/bin/env bash

main_menu() {
    echo "------------------------------
| Hyper Commander            |
| 0: Exit                    |
| 1: OS info                 |
| 2: User info               |
| 3: File and Dir operations |
| 4: Find Executables        |
------------------------------"
}

list_files() {
    echo "The list of files and directories:"
    arr=(*)
    for item in "${arr[@]}"; do
        if [[ -f "$item" ]]; then
            echo "F $item"
        elif [[ -d "$item" ]]; then
            echo "D $item"
        fi
    done
}

file_menu() {
    echo "---------------------------------------------------
| 0 Main menu | 'up' To parent | 'name' To select |
---------------------------------------------------"
}

file_options_menu() {
    echo "---------------------------------------------------------------------
| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |
---------------------------------------------------------------------"
}

file_operations() {
    while true; do
        file_options_menu
        read selection
        case "$selection" in

            0)
                break;;
            1)
                rm "$option"
                echo "$option has been deleted."
                break;;
            2)
                echo "Enter the new file name:"
                read new_name
                mv "$option" "$new_name"
                echo "$option has been renamed as $new_name"
                break;;
            3)
                chmod 666 "$option"
                echo "Permissions have been updated."
                ls -l "$option"
                break;;
            4)
                chmod 664 "$option"
                echo "Permissions have been updated."
                ls -l "$option"
                break;;
            *)
                ;;
        esac
    done
}

file_dir_operations() {
    while true; do
        echo ""
        list_files
        echo ""
        file_menu
        read option
        case "$option" in

            0)
		echo ""
                break;;
            "up")
                cd ..;;
            *)
                if [[ -f "$option" ]]; then
                    file_operations
                elif [[ -d "$option" ]]; then
                    cd "$option"
                else
                    echo "Invalid input!"
                fi;;
        esac
    done
}

echo "Hello $USER!"
while true; do
    main_menu
    read input
    case "$input" in
    
        0)
            echo "Farewell!"
            break;;
        1)
            uname -no
	    echo "";;
        2)
            whoami
	    echo "";;
        3)
            file_dir_operations;;
        4)
            echo ""
            echo "Enter an executable name:"
            read executable
            if ! [[ -x "$(which "$executable")" ]]; then
                echo -e "The executable with that name does not exist!\n"
            else
                echo -n "Located in: "
                which "$executable"
                echo "Enter arguments:"
                read arguments
                "$executable" "$arguments"
		echo ""
            fi;;
        *)
            echo "Invalid option!"
	    echo "";;
    esac
done