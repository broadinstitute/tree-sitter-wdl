version 1.0

task Minimap2 {
    input {
        File ref_fasta
    }
    command <<<
        set -euxo pipefail
        
        path="~{ref_fasta}"
        fname="${path##*/}"
        
        echo "\>>>"
        echo "\~{"
        
        if [[ "${fname}" =~ \.gz$ ]]; then
            gunzip -c ~{ref_fasta} > "${fname}"
        else
            cp ~{ref_fasta} "${fname}"
        fi
    >>>
}