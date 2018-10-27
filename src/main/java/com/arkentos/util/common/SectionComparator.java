/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.arkentos.util.common;

import com.arkentos.util.mapping.Section;
import java.util.Comparator;

/**
 *
 * @author chanuka
 */
public class SectionComparator implements Comparator<Section> {

    public int compare(Section _first, Section _second) {
            return _first.getSortkey().compareTo(_second.getSortkey());            
    }

}
