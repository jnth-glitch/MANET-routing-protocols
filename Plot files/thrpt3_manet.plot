set terminal pdf
set output "Manet_throughput3.pdf"
set title "AODV vs DSR vs DSDV \nTHROUGHPUT"
set ylabel "Average Throughput"
set xlabel "Protocols"
set style data histogram
set style fill solid
set style histogram clustered
plot 'throughput3.data' using 2:xtic(1) title "Source 1", '' using 3 title "Source 2"
