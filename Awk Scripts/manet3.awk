BEGIN{
	#For Source 1 (n0 -> n9)
	sent1= 0
	receive1= 0
	
	pckt_size1= 0
	last_pckt1= 0.0
	
	#For Source 2 (n14 -> n10)
	sent2= 0
	receive2= 0

	pckt_size2= 0
	last_pckt2= 0.0

}

{
	event= $1
	time= $2
	node= $3
	agent= $4
	packetSize= $8
	
	if(event == "s" && agent == "AGT"){
		if(node == "_0_"){
			sent1++
		}
		
		else if(node == "_14_"){
			sent2++
		}
	}
	
	if(event == "r" && agent == "AGT"){
		if(node == "_9_"){
			pckt_size1= pckt_size1 + packetSize
			last_pckt1= time
			receive1++
		}
		
		else if(node == "_10_"){
			pckt_size2 += packetSize
			last_pckt2= time
			receive2++
		}
	}
	
}

END{
	printf("\n==================== SOURCE 1 ========================\n")
	printf("\nPackets delivered by source 1 :%d ",sent1)
	printf("\nPackets recieved by destination 1:%d ",receive1)
	printf("\nPacket Delivery Ratio of Source 1: %d",(receive1 / sent1) * 100)
	printf("\nThroughput of Source 1 (in Kbps): %f\n", (pckt_size1 * 8) / last_pckt1 / 1000)
	printf("\n==================== SOURCE 2 =======================\n")
	printf("\nPackets delivered by source 2 :%d ",sent2)
	printf("\nPackets recieved by destination 2:%d ",receive2)
	printf("\nPacket Delivery Ratio of Source 2:%d ",(receive2 / sent2) * 100)
	printf("\nThroughput of Source 2 (in Kbps): %f \n", (pckt_size2 * 8) / last_pckt2 / 1000)
}







