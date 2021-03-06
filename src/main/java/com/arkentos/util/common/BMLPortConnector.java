/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.util.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.net.UnknownHostException;
import static oracle.jrockit.jfr.events.Bits.intValue;

/**
 *
 * @author jayana_i
 */
public class BMLPortConnector {

    private Socket client;
    private BufferedReader br;
    private PrintWriter pw;
    private String IPAddress;
    private int PORT;
//    private CommonDAO commondao = null;
//    private Smsserverconfigurations comondata = null;

    public BMLPortConnector(String IPAddress, int PORT) throws SocketException, SocketTimeoutException, IOException, Exception {
        this.IPAddress = IPAddress;
        this.PORT = PORT;
        System.out.println("called BMLPortConnector cons");
        try {

            String ip = IPAddress;
            int port = PORT;
            InetAddress inetAdd = InetAddress.getByName(ip); // get the ip address
            SocketAddress serverAdd = new InetSocketAddress(inetAdd, port);  // get the socket address

            client = new Socket(); // create an unconnected socket client
            client.connect(serverAdd, 1000); // connect the client to the server
            client.setSoTimeout(1000);

            br = new BufferedReader(new InputStreamReader(client.getInputStream()));  //reads text from a character-input stream
            pw = new PrintWriter(client.getOutputStream()); //prints formatted representations of objects to a text-output stream

        } catch (SocketException e) {
            System.out.println("SocketException " + e.getMessage());
            throw e;
        } catch (SocketTimeoutException e) {
            System.out.println("SocketTimeoutException " + e.getMessage());
            throw e;
        } catch (IOException ex) {
            System.out.println("IOException " + ex.getMessage());
            throw ex;
        } catch (Exception ex) {
            System.out.println("Exception " + ex.getMessage());
            throw ex;
        }

    }

    public void sendPacket(String request) throws Exception {
        pw.println(request);
        pw.flush();
    }

    public String receivePacket() throws Exception {
        String response;

        response = br.readLine(); // read the response from the socket
        if (response == null) {
            response = "";
        }
        return response;
    }

    public void closeAll() throws Exception {
        if (client != null) {
            client.close();
        }
        if (br != null) {
            br.close();
        }
        if (pw != null) {
            pw.close();
        }
        client = null;
        br = null;
        pw = null;
    }

    public static boolean isReachable(String targetUrl) throws IOException {
        HttpURLConnection httpUrlConnection = (HttpURLConnection) new URL(
                targetUrl).openConnection();
        httpUrlConnection.setRequestMethod("HEAD");

        try {
            int responseCode = httpUrlConnection.getResponseCode();

            return responseCode == HttpURLConnection.HTTP_OK;
        } catch (UnknownHostException noInternetConnection) {
            return false;
        }
    }

}
