BEGIN { FS=OFS="\t" }
{
    if ( NR==1 ) {
        for ( i=1 ; i<=NF ; i++ ) {
            if ($i == "stim_file_index") {
                stim_file_index_col = i
            }
            if ($i == "stim_file") {
                stim_file_col = i
            }
            if ($i == "onset") {
                onset_col = i
            }
            if ($i == "duration") {
                duration_col = i
            }
        }
    }
    else {
        $(stim_file_col) = stim_file
        $(duration_col) = "1.000"
        $(onset_col) = ($stim_file_index_col - 1) ".000"
    }
    print
}