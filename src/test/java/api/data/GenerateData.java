package api.data;

import java.util.Random;

public class GenerateData {
	
	public static String getEmail() {
		String email = "aubreygenerated";
		String provider = "@tekschool.us";
		int randomNumber = (int) (Math.random() *10000);
		String autoEmail = email + randomNumber + provider;
		return autoEmail;
	}

	public static String getLicensePlate() {
		Random random = new Random(); 
		StringBuilder sb = new StringBuilder(); 
		String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; 
		int count = 4; 
		for (int i = 0; i < count; i++) { 
			int randomIndex = random.nextInt(letters.length()); 
			char randomChar = letters.charAt(randomIndex); 
			sb.append(randomChar); 
			} 
		for (int i = 0; i < 4; i++) { 
			int randomDigit = (int) (Math.random() * 10); 
			sb.append(randomDigit); 
			} 
		return sb.toString(); 
		}

		public static String getPhoneNumber() {
		String phoneNumber = "9";
		for (int i = 0; i < 9; i++) {
		phoneNumber += (int) (Math.random() * 10);
		}
		return phoneNumber;
		}
		
}
