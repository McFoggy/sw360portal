/*
 * Copyright Siemens AG, 2016. Part of the SW360 Portal Project.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.eclipse.sw360.portal.portlets.ecc;

import org.apache.log4j.Logger;
import org.apache.thrift.TException;
import org.eclipse.sw360.datahandler.thrift.components.ComponentService;
import org.eclipse.sw360.datahandler.thrift.components.Release;
import org.eclipse.sw360.datahandler.thrift.users.User;
import org.eclipse.sw360.portal.portlets.Sw360Portlet;
import org.eclipse.sw360.portal.users.UserCacheHolder;

import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

import static org.eclipse.sw360.portal.common.PortalConstants.RELEASE_LIST;

/**
 * @author alex.borodin@evosoft.com
 */
public class EccPortlet extends Sw360Portlet {

    private static final Logger log = Logger.getLogger(EccPortlet.class);

    @Override
    public void doView(RenderRequest request, RenderResponse response) throws IOException, PortletException {
        prepareStandardView(request);
        // Proceed with page rendering
        super.doView(request, response);
    }

    private void prepareStandardView(RenderRequest request) {
        final User user = UserCacheHolder.getUserFromRequest(request);
        ComponentService.Iface client = thriftClients.makeComponentClient();

        try {
            final List<Release> releaseSummary = client.getReleaseSummary(user);

            request.setAttribute(RELEASE_LIST, releaseSummary);

        } catch (TException e) {
            log.error("Could not fetch releases from backend", e);
            request.setAttribute(RELEASE_LIST, Collections.emptyList());
        }

    }

}
