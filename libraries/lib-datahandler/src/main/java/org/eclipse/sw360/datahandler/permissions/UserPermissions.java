/*
 * Copyright Siemens AG, 2014-2015. Part of the SW360 Portal Project.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 */
package org.eclipse.sw360.datahandler.permissions;

import org.eclipse.sw360.datahandler.thrift.users.RequestedAction;
import org.eclipse.sw360.datahandler.thrift.users.User;

import java.util.Collections;
import java.util.Map;
import java.util.Set;

import static org.eclipse.sw360.datahandler.thrift.users.UserGroup.ADMIN;

/**
 * Created by bodet on 16/02/15.
 *
 * @author cedric.bodet@tngtech.com
 */
public class UserPermissions extends DocumentPermissions<User> {


    protected UserPermissions(User document, User user) {
        super(document, user);
    }

    @Override
    public void fillPermissions(User other, Map<RequestedAction, Boolean> permissions) {
    }

    @Override
    public boolean isActionAllowed(RequestedAction action) {
        switch (action) {
            case READ:
                return true;
            case WRITE:
            case DELETE:
                return PermissionUtils.isUserAtLeast(ADMIN, user);
            default:
                return false;
        }
    }

    @Override
    protected Set<String> getContributors() {
        return Collections.emptySet();
    }

    @Override
    protected Set<String> getModerators() {
        return Collections.emptySet();
    }

}
