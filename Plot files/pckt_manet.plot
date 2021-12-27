set terminal pdf
set output "Manet_pcktdelivery.pdf"
set title "AODV vs DSR vs DSDV \nPACKET DELIVERY PERCENTAGE"
set ylabel "Packet Delivery Percentage"
set xlabel "Protocols"
set style data histogram
set style fill solid
set style histogram clustered
plot 'pckt_graph1.data' using 2:xtic(1) title "SOURCE 1",'' using 3 title "SOURCE 2"
