package com.semantator.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import edu.stanford.nlp.ling.CoreAnnotations;
import edu.stanford.nlp.neural.rnn.RNNCoreAnnotations;
import edu.stanford.nlp.pipeline.Annotation;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;
import edu.stanford.nlp.sentiment.SentimentCoreAnnotations;
import edu.stanford.nlp.trees.Tree;
import edu.stanford.nlp.util.CoreMap;

public class FileProcessingService {

	public Map<String, String> doctorData(List<String> data) {
		Properties props = new Properties();
		props.setProperty("annotators", "tokenize, ssplit, parse, sentiment");
		StanfordCoreNLP pipeline = new StanfordCoreNLP(props);
		String[] ratings = { "Very Negative", "Negative", "Neutral",
				"Positive", "Very Positive" };
		Map<String, String> finalData = new LinkedHashMap<String, String>();
		for (Iterator iterator = data.iterator(); iterator.hasNext();) {
			String string = (String) iterator.next();

			Annotation annotation = pipeline.process(string);
			for (CoreMap sentence : annotation
					.get(CoreAnnotations.SentencesAnnotation.class)) {
				Tree tree = sentence
						.get(SentimentCoreAnnotations.AnnotatedTree.class);
				int score = RNNCoreAnnotations.getPredictedClass(tree);
				finalData.put(string, ratings[score]);
			}

		}

		return finalData;

	}

	public void copyJSON(File fJSON, String mainPathJSON) throws IOException {
		File newFile = new File(mainPathJSON);
		if (!newFile.exists()) {
			newFile.createNewFile();
		}
		FileReader fileReader = new FileReader(fJSON);
		BufferedReader brJSON = new BufferedReader(fileReader);
		FileWriter fw = new FileWriter(newFile.getAbsoluteFile());
		BufferedWriter bw = new BufferedWriter(fw);
		String lineJSON;
		while ((lineJSON = brJSON.readLine()) != null) {
			// System.out.println(lineJSON);
			bw.write(lineJSON);
		}

		bw.close();
		fw.close();
		brJSON.close();
		fileReader.close();
	}

	public void writeJSON(String mainPathJSON, String data) throws IOException {
		File newFile = new File(mainPathJSON);
		if (!newFile.exists()) {
			newFile.createNewFile();
		}
		FileWriter fw = new FileWriter(newFile.getAbsoluteFile());
		BufferedWriter bw = new BufferedWriter(fw);
		bw.write(data);

		bw.close();
		fw.close();

	}

	public List<String> getFileNames(String path) {
		// TODO Auto-generated method stub
		File folder = new File(path);
		File[] listOfFiles = folder.listFiles();
		List<String> list = new ArrayList<String>();
		if (listOfFiles != null) {
			for (int i = 0; i < listOfFiles.length; i++) {
				if (listOfFiles[i].isFile()) {
					if (listOfFiles[i].getName().endsWith(".txtJSON")) {
						String name = listOfFiles[i].getName();
						name = name.substring(0, name.length() - 8);
						list.add(name);
					}
				}
			}
		}
		return list;
	}

}
