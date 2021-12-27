#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    CMUPriQueue		     ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     16                         ;# number of mobilenodes
set val(rp)     DSR                       ;# routing protocol
set val(x)      877                      ;# X dimension of topography
set val(y)      3345                      ;# Y dimension of topography
set val(stop)   30.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open dsr_trace2.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open dsr_trace2.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 16 nodes
set n0 [$ns node]
$n0 set X_ 442
$n0 set Y_ 426
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 588
$n1 set Y_ 425
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 526
$n2 set Y_ 527
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 628
$n3 set Y_ 543
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 741
$n4 set Y_ 529
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 734
$n5 set Y_ 434
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 903
$n6 set Y_ 434
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 777
$n7 set Y_ 340
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 678
$n8 set Y_ 294
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 589
$n9 set Y_ 282
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 482
$n10 set Y_ 294
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 405
$n11 set Y_ 338
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 745
$n12 set Y_ 155
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 591
$n13 set Y_ 128
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 508
$n14 set Y_ 183
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 883
$n15 set Y_ 291
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20

#===================================
#        Generate movement          
#===================================
if 0 {
$ns at 3 " $n0 setdest 261 580 150 " 
$ns at 15 " $n0 setdest 442 426 100 " 
$ns at 5 " $n2 setdest 450 579 150 " 
$ns at 15 " $n7 setdest 777 300 100 " 
$ns at 10 " $n10 setdest 640 300 150 " 
$ns at 15 " $n14 setdest 630 164 80 " 
}

$ns at 5 " $n0 setdest 261 580 150 " 
$ns at 15 " $n0 setdest 442 426 100 " 
$ns at 5 "$n11 setdest 405 380 100"
#$ns at 5 " $n2 setdest 470 527 100"
$ns at 8 " $n2 setdest 450 579 150 " 
$ns at 15 " $n7 setdest 777 300 100 " 
$ns at 10 " $n10 setdest 640 300 150 " 
$ns at 15 " $n14 setdest 630 164 80 " 

#===================================
#        Agents Definition        
#===================================
#Setup a UDP connection
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null2 [new Agent/Null]
$ns attach-agent $n6 $null2
$ns connect $udp0 $null2
$udp0 set packetSize_ 1500

#Setup a UDP connection
set udp1 [new Agent/UDP]
$ns attach-agent $n14 $udp1
set null3 [new Agent/Null]
$ns attach-agent $n15 $null3
$ns connect $udp1 $null3
$udp1 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a CBR Application over UDP connection
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 1.0Mb
$cbr0 set random_ null
$cbr0 set interval_ 0.05
$ns at 1.0 "$cbr0 start"
$ns at 29.0 "$cbr0 stop"

#Setup a CBR Application over UDP connection
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set packetSize_ 1000
$cbr1 set rate_ 1.0Mb
$cbr1 set random_ null
$cbr1 set interval_ 0.05
$ns at 1.0 "$cbr1 start"
$ns at 29.0 "$cbr1 stop"



#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam dsr_trace2.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
