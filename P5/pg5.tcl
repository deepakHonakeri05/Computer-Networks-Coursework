set opt(type) gsm
set opt(minth) 5
set opt(maxth) 10
set opt(adaptive) 1
set bwDL(gsm) 10000
set bwUL(gsm) 10000
set propDL(gsm) .500
set propUL(gsm) .500
set buf(gsm) 10
set ns [new Simulator]
set tf [open out51.tr w]
set nf [open out52.nam w]
$ns trace-all $tf
$ns namtrace-all $nf
set s [$ns node]
set bs1 [$ns node]
set ms [$ns node]
set bs2 [$ns node]
set d [$ns node]
proc cell_topo {} {
global ns s bs1 bs2 ms d
$ns duplex-link $s $bs1 3Mbps 10ms DropTail
$ns duplex-link $bs1 $ms 1Mbps 1ms RED
$ns duplex-link $ms $bs2 1Mbps 1ms RED
$ns duplex-link $bs2 $d 3Mbps 50ms DropTail puts "Cell Topology"
}
proc set_link_params {t} {
global ns bs1 ms bs2 bwUL bwDL propUL propDL buf
$ns bandwidth $bs1 $ms $bwDL($t) simplex
$ns bandwidth $ms $bs1 $bwUL($t) simplex
$ns bandwidth $bs2 $ms $bwDL($t) simplex
$ns bandwidth $ms $bs2 $bwUL($t) simplex
$ns delay $bs1 $ms $propDL($t) simplex
$ns delay $ms $bs1 $propDL($t) simplex
$ns delay $bs2 $ms $propDL($t) simplex
$ns delay $ms $bs2 $propDL($t) simplex
$ns queue-limit $bs1 $ms $buf($t)
$ns queue-limit $ms $bs1 $buf($t)
$ns queue-limit $bs2 $ms $buf($t)
$ns queue-limit $ms $bs2 $buf($t)
}
Queue/RED set summarystats_ true
Queue/DropTail set summarystats_ true
Queue/RED set adaptive_ $opt(adaptive)
Queue/RED set q_weight_ 0.0
Queue/RED set thresh_ $opt(minth)
Queue/RED set maxthresh_ $opt(maxth)
switch $opt(type) {
gsm - gprs - umts {cell_topo}
}
set_link_params $opt(type)
# Set up forward TCP connection
set tcp1 [$ns create-connection TCP/Sack1 $s TCPSink/Sack1 $d 0]
set ftp1 [[set tcp1] attach-app FTP]
$ns at 0.5 "$ftp1 start"
proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam out1.nam &
exit 0
}
$ns at 100 "finish"
$ns run

